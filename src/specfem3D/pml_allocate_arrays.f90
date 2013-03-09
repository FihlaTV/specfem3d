!=====================================================================
!
!               S p e c f e m 3 D  V e r s i o n  2 . 1
!               ---------------------------------------
!
!          Main authors: Dimitri Komatitsch and Jeroen Tromp
!    Princeton University, USA and CNRS / INRIA / University of Pau
! (c) Princeton University / California Institute of Technology and CNRS / INRIA / University of Pau
!                             July 2012
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
!
! United States and French Government Sponsorship Acknowledged.

subroutine pml_allocate_arrays()

  use pml_par
  use specfem_par, only: NSPEC_AB
  use constants, only: NDIM,NGLLX,NGLLY,NGLLZ

  implicit none

  ! local parameters
  integer :: ier

  ! C-PML spectral elements local indexing
  allocate(spec_to_CPML(NSPEC_AB),stat=ier)
  if(ier /= 0) stop 'error allocating array spec_to_CPML'

  ! C-PML element type array: 1 = face, 2 = edge, 3 = corner
  allocate(CPML_type(NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating array CPML_type'

  ! stores derivatives of ux, uy and uz with respect to x, y and z
  allocate(PML_dux_dxl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dux_dxl array'
  allocate(PML_dux_dyl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dux_dyl array'
  allocate(PML_dux_dzl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dux_dzl array'
  allocate(PML_duy_dxl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duy_dxl array'
  allocate(PML_duy_dyl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duy_dyl array'
  allocate(PML_duy_dzl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duy_dzl array'
  allocate(PML_duz_dxl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duz_dxl array'
  allocate(PML_duz_dyl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duz_dyl array'
  allocate(PML_duz_dzl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duz_dzl array'

  allocate(PML_dux_dxl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dux_dxl_new array'
  allocate(PML_dux_dyl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dux_dyl_new array'
  allocate(PML_dux_dzl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dux_dzl_new array'
  allocate(PML_duy_dxl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duy_dxl_new array'
  allocate(PML_duy_dyl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duy_dyl_new array'
  allocate(PML_duy_dzl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duy_dzl_new array'
  allocate(PML_duz_dxl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duz_dxl_new array'
  allocate(PML_duz_dyl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duz_dyl_new array'
  allocate(PML_duz_dzl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_duz_dzl_new array'

  ! stores derivatives of potential with respect to x, y and z
  allocate(PML_dpotential_dxl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dpotential_dxl array'
  allocate(PML_dpotential_dyl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dpotential_dxl array'
  allocate(PML_dpotential_dzl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dpotential_dxl array'

  allocate(PML_dpotential_dxl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dpotential_dxl_new array'
  allocate(PML_dpotential_dyl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dpotential_dxl_new array'
  allocate(PML_dpotential_dzl_new(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating PML_dpotential_dxl_new array'

  ! stores C-PML memory variables
  allocate(rmemory_dux_dxl_x(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dux_dxl_x array'
  allocate(rmemory_dux_dyl_x(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dux_dyl_x array'
  allocate(rmemory_dux_dzl_x(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dux_dzl_x array'
  allocate(rmemory_duy_dxl_x(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duy_dxl_x array'
  allocate(rmemory_duy_dyl_x(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duy_dyl_x array'
  allocate(rmemory_duz_dxl_x(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duz_dxl_x array'
  allocate(rmemory_duz_dzl_x(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duz_dzl_x array'

  allocate(rmemory_dux_dxl_y(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dux_dxl_y array'
  allocate(rmemory_dux_dyl_y(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dux_dyl_y array'
  allocate(rmemory_duy_dxl_y(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duy_dxl_y array'
  allocate(rmemory_duy_dyl_y(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duy_dyl_y array'
  allocate(rmemory_duy_dzl_y(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duy_dzl_y array'
  allocate(rmemory_duz_dyl_y(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duz_dyl_y array'
  allocate(rmemory_duz_dzl_y(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duz_dzl_y array'

  allocate(rmemory_dux_dxl_z(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dux_dxl_z array'
  allocate(rmemory_dux_dzl_z(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dux_dzl_z array'
  allocate(rmemory_duy_dyl_z(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duy_dyl_z array'
  allocate(rmemory_duy_dzl_z(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duy_dzl_z array'
  allocate(rmemory_duz_dxl_z(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duz_dxl_z array'
  allocate(rmemory_duz_dyl_z(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duz_dyl_z array'
  allocate(rmemory_duz_dzl_z(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_duz_dzl_z array'

  allocate(rmemory_dpotential_dxl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dpotential_dxl array'
  allocate(rmemory_dpotential_dyl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dpotential_dyl array'
  allocate(rmemory_dpotential_dzl(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_dpotential_dzl array'

  ! stores C-PML memory variables needed for displacement
  allocate(rmemory_displ_elastic(NDIM,NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_displ_elastic array'

  ! stores C-PML memory variables needed for potential
  allocate(rmemory_potential_acoustic(NGLLX,NGLLY,NGLLZ,NSPEC_CPML,3),stat=ier)
  if(ier /= 0) stop 'error allocating rmemory_displ_elastic array'

  ! stores C-PML contribution to update acceleration to the global mesh
  allocate(accel_elastic_CPML(NDIM,NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating accel_elastic_CPML array'

  ! stores C-PML contribution to update the second derivative of the potential to the global mesh
  allocate(potential_dot_dot_acoustic_CPML(NGLLX,NGLLY,NGLLZ,NSPEC_CPML),stat=ier)
  if(ier /= 0) stop 'error allocating potential_dot_dot_acoustic_CPML array'

  spec_to_CPML(:) = 0

  CPML_type(:) = 0

  PML_dux_dxl(:,:,:,:) = 0._CUSTOM_REAL
  PML_dux_dyl(:,:,:,:) = 0._CUSTOM_REAL
  PML_dux_dzl(:,:,:,:) = 0._CUSTOM_REAL
  PML_duy_dxl(:,:,:,:) = 0._CUSTOM_REAL
  PML_duy_dyl(:,:,:,:) = 0._CUSTOM_REAL
  PML_duy_dzl(:,:,:,:) = 0._CUSTOM_REAL
  PML_duz_dxl(:,:,:,:) = 0._CUSTOM_REAL
  PML_duz_dyl(:,:,:,:) = 0._CUSTOM_REAL
  PML_duz_dzl(:,:,:,:) = 0._CUSTOM_REAL

  PML_dux_dxl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_dux_dyl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_dux_dzl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_duy_dxl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_duy_dyl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_duy_dzl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_duz_dxl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_duz_dyl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_duz_dzl_new(:,:,:,:) = 0._CUSTOM_REAL

  PML_dpotential_dxl(:,:,:,:) = 0._CUSTOM_REAL
  PML_dpotential_dyl(:,:,:,:) = 0._CUSTOM_REAL
  PML_dpotential_dzl(:,:,:,:) = 0._CUSTOM_REAL

  PML_dpotential_dxl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_dpotential_dyl_new(:,:,:,:) = 0._CUSTOM_REAL
  PML_dpotential_dzl_new(:,:,:,:) = 0._CUSTOM_REAL

  rmemory_dux_dxl_x(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_dux_dyl_x(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_dux_dzl_x(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duy_dxl_x(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duy_dyl_x(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duz_dxl_x(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duz_dzl_x(:,:,:,:,:) = 0._CUSTOM_REAL

  rmemory_dux_dxl_y(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_dux_dyl_y(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duy_dxl_y(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duy_dyl_y(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duy_dzl_y(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duz_dyl_y(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duz_dzl_y(:,:,:,:,:) = 0._CUSTOM_REAL

  rmemory_dux_dxl_z(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_dux_dzl_z(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duy_dyl_z(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duy_dzl_z(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duz_dxl_z(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duz_dyl_z(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_duz_dzl_z(:,:,:,:,:) = 0._CUSTOM_REAL

  rmemory_dpotential_dxl(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_dpotential_dyl(:,:,:,:,:) = 0._CUSTOM_REAL
  rmemory_dpotential_dzl(:,:,:,:,:) = 0._CUSTOM_REAL

  rmemory_displ_elastic(:,:,:,:,:,:) = 0._CUSTOM_REAL

  rmemory_potential_acoustic(:,:,:,:,:) = 0._CUSTOM_REAL

  accel_elastic_CPML(:,:,:,:,:) = 0._CUSTOM_REAL

  potential_dot_dot_acoustic_CPML(:,:,:,:) = 0._CUSTOM_REAL

end subroutine pml_allocate_arrays
