module ppm_mom6

use regrid_edge_values, only  : edge_values_implicit_h4
use PPM_functions, only       : PPM_reconstruction
use PLM_functions, only       : PLM_reconstruction

implicit none

public ppm_reconstructions, plm_reconstructions

contains

subroutine plm_reconstructions(n0, h0, u0, ppoly_r_E, poly_coeffs)
  integer,               intent(in   ) :: n0 !< Number of cells
  double precision, dimension(n0),   intent(in   ) :: h0 !< Cell widths
  double precision, dimension(n0),   intent(in   ) :: u0 !< Cell averages
  double precision, dimension(n0,2), intent(  out) :: ppoly_r_E ! Edge values
  double precision, dimension(n0,2), intent(  out) :: poly_coeffs !< Coefficients of PPM reconstruction

  ppoly_r_E(:,:) = 0.
  poly_coeffs(:,:) = 0.
  call PLM_reconstruction( n0, h0, u0, ppoly_r_E, poly_coeffs )

end subroutine plm_reconstructions

subroutine ppm_reconstructions(n0, h0, u0, ppoly_r_E, poly_coeffs)
  integer,               intent(in   ) :: n0 !< Number of cells
  double precision, dimension(n0),   intent(in   ) :: h0 !< Cell widths
  double precision, dimension(n0),   intent(in   ) :: u0 !< Cell averages
  double precision, dimension(n0,2), intent(  out) :: ppoly_r_E ! Edge values
  double precision, dimension(n0,3), intent(  out) :: poly_coeffs !< Coefficients of PPM reconstruction

  ppoly_r_E(:,:) = 0.
  poly_coeffs(:,:) = 0.
  call edge_values_implicit_h4( n0, h0, u0, ppoly_r_E)
  call PPM_reconstruction( n0, h0, u0, ppoly_r_E, poly_coeffs )

end subroutine ppm_reconstructions

end module ppm_mom6
