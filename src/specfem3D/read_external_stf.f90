!=====================================================================
!
!               S p e c f e m 3 D  V e r s i o n  3 . 0
!               ---------------------------------------
!
!     Main historical authors: Dimitri Komatitsch and Jeroen Tromp
!                        Princeton University, USA
!                and CNRS / University of Marseille, France
!                 (there are currently many more authors!)
! (c) Princeton University and CNRS / University of Marseille, July 2012
!
! This program is free software; you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation; either version 2 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License along
! with this program; if not, write to the Free Software Foundation, Inc.,
! 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
!
!=====================================================================

  subroutine read_EXTERNAL_SOURCE_TIME_FUNCTION(isource,user_source_time_function,EXTERNAL_SOURCE_TIME_FUNCTION_filename)

! reads in an external source time function file

  use constants, only: MAX_STRING_LEN,CUSTOM_REAL,IOSTF

  use shared_parameters, only: NSTEP,NSTEP_STF,NSOURCES_STF

  implicit none

  integer,intent(in) :: isource
  !! VM VM use NSTEP_STF, NSOURCES_STF which are always OK:
  !! in case of USE_EXTERNAL_SOURCE_FILE, they are equal to NSTEP,NSOURCES
  !! when .not. USE_EXTERNAL_SOURCE_FILE they are equal to 1,1.
  real(kind=CUSTOM_REAL), dimension(NSTEP_STF, NSOURCES_STF), intent(out) :: user_source_time_function

  character(len=MAX_STRING_LEN),intent(in) :: EXTERNAL_SOURCE_TIME_FUNCTION_filename

  ! local variables below
  integer :: i,ier
  character(len=256) :: line

  ! clear the array for that source
  user_source_time_function(:,isource) = 0._CUSTOM_REAL

  ! opens specified file
  open(IOSTF,file=trim(EXTERNAL_SOURCE_TIME_FUNCTION_filename),status='old',action='read',iostat=ier)
  if (ier /= 0) then
    print *,'Error could not open external source file: ',trim(EXTERNAL_SOURCE_TIME_FUNCTION_filename)
    stop 'Error opening external source time function file'
  endif

  ! gets number of file entries
  i = 0
  do while (ier == 0)
    read(IOSTF,"(a256)",iostat=ier) line
    if (ier == 0) then
      ! suppress leading white spaces, if any
      line = adjustl(line)

      ! skip empty/comment lines
      if (len_trim(line) == 0) cycle
      if (line(1:1) == '#' .or. line(1:1) == '!') &
        stop 'error in format of EXTERNAL_SOURCE_TIME_FUNCTION_filename, no comments are allowed in it'

      ! increases counter
      i = i + 1
    endif
  enddo
  rewind(IOSTF)

  if (i < 1) stop 'error: the number of time steps in EXTERNAL_SOURCE_TIME_FUNCTION_filename is < 1'

  if (i > NSTEP_STF) then
    print *
    print *,'****************************************************************************************'
    print *,'Warning: EXTERNAL_SOURCE_TIME_FUNCTION_filename contains more than NSTEP_STF time steps,'
    print *,'         only the first NSTEP_STF will be read, all the others will be ignored.'
    print *,'****************************************************************************************'
    print *
  endif

  ! checks number of time steps read
  if (i < NSTEP) then
    print *,'Problem when reading external source time file: ', trim(EXTERNAL_SOURCE_TIME_FUNCTION_filename)
    print *,'  number of time steps in the simulation = ',NSTEP
    print *,'  number of time steps read from the source time function = ',i
    print *,'Please make sure that the number of time steps in the external source file read is greater or &
             &equal to the number of time steps in the simulation'
    stop 'Error invalid number of time steps in external source time file'
  endif

  ! read the source values
  do i = 1, NSTEP_STF
    read(IOSTF,*,iostat=ier) user_source_time_function(i,isource)
    if (ier /= 0) then
      print *,'Problem when reading external source time file: ', trim(EXTERNAL_SOURCE_TIME_FUNCTION_filename)
      print *,'Please check, file format should be: #time #stf-value'
      stop 'Error reading external source time file with invalid format'
    endif
  enddo

  ! closes external STF file
  close(IOSTF)

  end subroutine read_EXTERNAL_SOURCE_TIME_FUNCTION

