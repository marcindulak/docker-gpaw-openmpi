from ase import Atoms
from gpaw import GPAW, PW
h2 = Atoms('H2', [(0, 0, 0), (0, 0, 0.74)])
h2.center(vacuum=2.5)
h2.set_calculator(GPAW(xc='PBE', mode=PW(300), txt='h2.txt'))
h2.get_potential_energy()
h2.get_forces()
