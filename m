Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E07AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E8D20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551868472;
	bh=DxgZNOY9rZNcASD8Xp9nO42jFBknWI9vNUVsETIe1ts=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xZpe0EXChXuq4p8dB79xZsYzMHQeVD2xwweLkeN3rBiTpPoI1dCDMiJqdHO4Yxb+V
	 AFeHMPxrjThMo2jzunqsz+zNylKgmx5v5rEXP8gHOCcVmeFsAcHqQEXFQuZsdCDs1n
	 TorqK5KR8gS3GaNU1I3ttcj0m3eJ3xLhZ4mgzS/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfCFKeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfCFKea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:34:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD5620661;
        Wed,  6 Mar 2019 10:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551868466;
        bh=DxgZNOY9rZNcASD8Xp9nO42jFBknWI9vNUVsETIe1ts=;
        h=Date:From:To:Cc:Subject:From;
        b=LMFvWOuy3aIMtWpMIyL7eLYgqSCZzNvKBJN08Lrw1J5BePkSJ+ddG45lh456ekUI5
         cFdmbP9tcWmrt4LYWyTCnDbRJe1tEm+PtG/qllQ6DUeLL1uc9Qw3WR0sF5a1MCly33
         vZVwTL0b85ZV7os0PG4mRrW13gk+FpiXh81DMU7I=
Date:   Wed, 6 Mar 2019 11:34:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver patches for 5.1-rc1
Message-ID: <20190306103423.GA10676@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.1-rc1

for you to fetch changes up to 1f08c4a54b7cb62ed6450808c37d06c907f1a2dd:

  staging: mt7621-dma: remove license boilerplate text (2019-03-03 09:25:42 +0100)

----------------------------------------------------------------
Staging/IIO patches for 5.1-rc1

Here is the big staging/iio driver pull request for 5.1-rc1.

Lots of good IIO driver updates and cleanups in here as always.
Combined with the removal of the xgifb driver, we have a net "loss" of
over 9000 lines in the pull request, always a nice thing.

As the outreachy application process is currently happening, there are
loads of tiny checkpatch cleanup fixes all over the staging tree, which
accounts for the majority of the fixups.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adham Abozaeid (1):
      staging: wilc1000: remove redundant reset of station statistics

Aditya Pakki (3):
      iio: adc: xilinx: check return value of xadc_write_adc_reg
      staging: rts5208: Add a check for ms_read_extra_data
      Staging: rts5208: Fix error handling on rtsx_send_cmd

Ajay Singh (40):
      staging: wilc1000: make use of get_unaligned_le16/le32 to pack data
      staging: wilc1000: refactor wilc_wlan_set_bssid()
      staging: wilc1000: use 'struct' to pack cfg header frame in wilc_wlan_cfg_commit()
      staging: wilc1000: remove the use of scan shadow buffer
      staging: wilc1000: make use of cfg80211_inform_bss_frame()
      staging: wilc1000: corrected order to pack join param buffer
      staging: wilc1000: use struct to pack join parameters for FW
      staging: wilc1000: rename hidden_network related data structure
      staging: wilc1000: use single struct for 'connect' related parameters
      staging: wilc1000: refactor information message parsing logic
      staging: wilc1000: remove 'disconnect_info' structure
      staging: wilc1000: refactor handle_set_mcast_filter()
      staging: wilc1000: avoid the use of typedef for function pointers
      staging: wilc1000: avoid the use of 'wilc_wfi_mon' static variable
      staging: wilc1000: remove conditional lock in wilc_wfi_deinit_mon_interface()
      staging: wilc1000: remove redundant macros for radiotap
      staging: wilc1000: remove unnecessary debug log messages
      staging: wilc1000: rename timeout related macros
      staging: wilc1000: make use of iface type to identify p2p interface
      staging: wilc1000: refactor scan() cfg80211 ops callback
      staging: wilc1000: remove use of 'terminated_handle' static variable
      staging: wilc1000: refactor linux_wlan_init_test_config()
      staging: wilc1000: refactor code to use cookie information
      staging: wilc1000: use random number for cookie instead of pointer
      staging: wilc1000: avoid use of interface names for validation
      staging: wilc1000: add check before performing operation on net_device
      staging: wilc1000: remove unused struct 'add_sta_param'
      staging: wilc1000: avoid use of 'hif_deinit_lock' static variable
      staging: wilc1000: avoid use of static variable in linux_mon.c
      staging: wilc1000: move static variable 'wlan_channel' to 'wilc' struct
      staging: wilc1000: move 'curr_channel' static variable in 'wilc' struct
      staging: wilc1000: define p2p related static variable as constants
      staging: wilc1000: fix to set correct value for 'vif_num'
      staging: wilc1000: add 'wilc_' prefix to have proper namespace
      staging: wilc1000: move macro and function prototype from wilc_wlan_if.h file
      staging: wilc1000: avoid function forward declaration in wilc_sdio.c file
      staging: wilc1000: added 'wilc_' prefix for function in wilc_sdio.c file
      staging: wilc1000: rename wilc_frmw_to_linux()
      staging: wilc1000: remove 'linux_' prefix in function names
      staging: wilc1000: rename linux_wlan.c and linux_mon.c

Alexander Schroth (1):
      staging: comedi: ni_pcidio: make defines uppercase

Alexandru Ardelean (1):
      staging: iio: cdc: ad7152: remove driver completely

Andreas Brauchli (3):
      iio: Add modifiers for ethanol and H2 gases
      iio: chemical: sgp30: Support Sensirion SGP30/SGPC3 sensors
      iio: chemical: sgp30: add device tree support

Andrew F. Davis (10):
      staging: android: ion: Add proper header information
      staging: android: ion: Remove empty ion_ioctl_dir() function
      staging: android: ion: Merge ion-ioctl.c into ion.c
      staging: android: ion: Remove leftover comment
      staging: android: ion: Remove struct ion_platform_heap
      staging: android: ion: Fixup some white-space issues
      staging: android: ion: Sync comment docs with struct ion_buffer
      staging: android: ion: Remove base from ion_carveout_heap
      staging: android: ion: Remove base from ion_chunk_heap
      staging: android: ion: Remove unused headers

Anson Huang (4):
      iio: magnetometer: mag3110: add vdd/vddio regulator operation support
      iio: light: isl29018: add vcc regulator operation support
      dt-bindings: iio: accel: mma8452: add power supplies property
      iio: accell: mma8452: add vdd/vddio regulator operation support

Artur Rojek (3):
      dt-bindings: iio/adc: Add docs for Ingenic JZ47xx SoCs ADC.
      dt-bindings: iio/adc: Add bindings for Ingenic JZ47xx SoCs ADC.
      IIO: add Ingenic JZ47xx ADC driver.

Beniamin Bia (2):
      staging: iio: frequency: ad9833: Get frequency value statically
      staging: iio: frequency: ad9833: Load clock using clock framework

Bhagyashri Dighole (4):
      staging: netlogic: Modify coding style alignments
      staging: netlogic: Add SPDX-License-Identifier tag at the top
      staging: netlogic: Remove boilerplate license text
      staging: speakup: fix line over 80 characters.

Bhanusree Pola (13):
      staging: mt7621-mmc: Prefer using BIT macro
      staging: erofs: match alignment with open parentheses
      Staging: rtl8192e: Replace license text with SPDX identifier
      Staging: mt7621_dma: Prefer unsigned int over just unsigned
      Staging: mt761-dma: Alignment should match open parenthesis
      Staging: fbtft: Alignment should match open parenthesis
      Staging: fbtft: Extra blank line not required before '}'
      Staging: fbtft: Fix line over 80 characters
      Staging: fwserial: Add blank line after declarations
      Staging: ks7010: Match alignments with open parenthesis
      Staging: greybus: Do not use multiple blank lines
      Staging: greybus: Blank lines not required before '}'
      Staging: greybus: Alignment should match open parenthesis

Bharath Vedartham (2):
      staging: netlogic: replace ---help--- with help in Kconfig
      staging: wlan-ng: replace ---help--- with help in Kconfig

Bo YU (2):
      staging: wilc1000: fix incorrent type assignment
      staging: wilc1000: fix incorrent type in initializer

Brajeswar Ghosh (1):
      staging/android/vsoc: Remove duplicate header

Carlos Henrique Lima Melara (1):
      staging: mt7621-eth/ethtool.c: Correction of SPDX license identifier

Cezary Kierzyk (1):
      staging: rtlwifi: replace ---help--- with help in Kconfig

Chao Yu (1):
      staging: erofs: clean up erofs_map_blocks_iter

Chengguang Xu (3):
      staging: erofs: fix potential double iput in erofs_read_super()
      staging: erofs: remove redundant likely/unlikely annotation in namei.c
      staging: erofs: remove redundant unlikely annotation in unzip_vle.c

Colin Ian King (7):
      staging: rtl8712: clean up various indentation and coding style issues
      staging: rtl8192e: fix various indentation issues
      staging: rtl8723bs: fix indentation issue with return statement
      staging: most: cdev: add missing check for cdev_add failure
      staging: rtl8192u: remove redundant nul check on pointer dev
      iio: adc: ads124s08: fix spelling mistake "converions" -> "conversions"
      staging: rtlwifi: fix spelling mistake: "Hightest" -> "Highest"

Dan Carpenter (2):
      Staging: rtl8723bs: remove some dead code
      iio: chemical: sps30: fix a loop timeout test

Dan Murphy (2):
      iio: ti-ads124s08: Add DT binding documentation
      iio: adc: Add the TI ads124s08 ADC code

Daniel Drake (1):
      iio: st_accel: use ACPI orientation data

Daniel Smith (1):
      staging: speakup: Fix coding style

Daniel Vetter (1):
      staging/xgifb: Needs to be converted to a drm driver

Felipe Cardoso Resende (1):
      drivers: staging: rtlwifi: Start statement on a tabstop

Florian B¸stgens (1):
      staging: rtl8188eu: Refactoring struct ndis_802_11_ssid from CamelCase to correct code style.

Florian Fainelli (1):
      staging: fsl-dpaa2: ethsw: Add missing netdevice check

Gao Xiang (20):
      staging: erofs: fix return type of erofs_workgroup_get
      staging: erofs: add document
      staging: erofs: fix fast symlink w/o xattr when fs xattr is on
      staging: erofs: remove unneeded inode_operations
      staging: erofs: move erofs_xattr_handlers to xattr.h
      staging: erofs: sunset erofs_workstation_cleanup_all
      staging: erofs: localize erofs_workgroup_get
      staging: erofs: move shrink accounting inside the function
      staging: erofs: staticize erofs_shrink_count, erofs_shrink_scan
      staging: erofs: drop the extern prefix for function definitions
      staging: erofs: use xattr_prefix to wrap up
      staging: erofs: complete POSIX ACL support
      staging: erofs: keep corrupted fs from crashing kernel in erofs_namei()
      staging: erofs: fix race of initializing xattrs of a inode at the same time
      staging: erofs: remove rcu_read_lock() in erofs_try_to_free_cached_page
      staging: erofs: no need to take page lock in readdir
      staging: erofs: switch to ->iterate_shared()
      staging: erofs: compressed_pages should not be accessed again after freed
      staging: erofs: fix illegal address access under memory pressure
      staging: erofs: fix mis-acted TAIL merging behavior

George Hilliard (2):
      staging: Move ralink-gdma to its own directory
      staging: Mediatek: Use individual config flags in Makefile

Greg Kroah-Hartman (6):
      Merge 5.0-rc2 into staging-next
      staging: xgifb: delete the driver
      Merge 5.0-rc4 into staging-next
      Merge tag 'iio-for-5.1a' of git://git.kernel.org/.../jic23/iio into staging-next
      Merge 5.0-rc6 into staging-next
      Merge tag 'iio-for-5.1b' of git://git.kernel.org/.../jic23/iio into staging-next

Gregory CLEMENT (2):
      dt-bindings: iio: adc: move lpc32xx-adc out of staging
      iio:adc:lpc32xx use SPDX-License-Identifier

Guilherme Tadashi Maeoka (1):
      Staging: mt7621-pci: Fix space required coding style

Gustavo A. R. Silva (4):
      staging: mt7621-dma: Use struct_size() in devm_kzalloc()
      staging: rtl8188eu: Replace kzalloc with kcalloc
      staging: comedi: ni_660x: fix missing break in switch statement
      staging: vt6656: key: Mark expected switch fall-throughs

Hardik Singh Rathore (2):
      staging: iio: adt7316: drop unnecessary initialization of variables
      staging: iio: ad7816: drop unnecessary initialization of variables

Himadri Pandya (14):
      staging: rtl8192e: rename Channel to channel style
      staging: rtl8192e: rename ChannelPlan[] to channel_array[] - style
      staging: rtl8192e: rename Len to len - style
      staging: rtl8192e: rename members of struct chnl_txpow_triple - style
      staging: rtl8192e: rename members of struct rt_dot11d_info - style
      staging: rtl8192e: rename members of struct rtllib_device - style
      staging: rtl8192e: rename function Dot11d_Channelmap to dot11d_channel_map - style
      staging: rtl8192e: rename function Dot11d_Reset to dot11d_reset - style
      staging: rtl8192e: rename function Dot11d_UpdateCountryIe to dot11d_update_country - style
      staging: rtl8192e: rename function DOT11D_ScanComplete to dot11d_scan_complete - style
      staging: rtl8192e: rename local variables of function dot11d_update_country - style
      staging: rtl8192e: rename parameters of function dot11d_update_country - style
      staging: rtl8192e: rename function cpMacAddr to copy_mac_addr - style
      staging: rtl8192e: rename macro arguments to avoid camel case - style

Hyun Kwon (1):
      staging: android: ion: Add the GPL exception for syscalls

Ian Abbott (1):
      staging: comedi: ni_tio: Allocate shadow regs for each counter chip

Jann Horn (1):
      staging: visornic: use skb_put_zero() instead of open-coded version

Jasminko Dedic (1):
      staging: mt7621-spi: Clean up comparison to NULL

Jeremy Fertic (11):
      staging: iio: adt7316: fix register and bit definitions
      staging: iio: adt7316: invert the logic of the check for an ldac pin
      staging: iio: adt7316: use correct variable in DAC_internal_Vref read
      staging: iio: adt7316: allow adt751x to use internal vref for all dacs
      staging: iio: adt7316: remove dac vref buffer bypass from adt751x
      staging: iio: adt7316: change interpretation of write to dac update mode
      staging: iio: adt7316: correct spelling of ADT7316_DA_EN_VIA_DAC_LDCA
      staging: iio: adt7316: fix dac_bits assignment
      staging: iio: adt7316: fix handling of dac high resolution option
      staging: iio: adt7316: fix the dac read calculation
      staging: iio: adt7316: fix the dac write calculation

Jeremy Sowden (3):
      staging: erofs: fixed -Wmissing-prototype warnings by making functions static.
      staging: erofs: fixed -Wmissing-prototype warnings by moving prototypes to header file.
      staging: ks7010: removed custom Michael MIC implementation.

Jin Chen (1):
      staging: sm750fb: Rename setDisplayControl to set_display_control - style

Jitendra Khasdev (1):
      staging: comedi: Removed not necessary braces for single block

Jonathan Cameron (1):
      iio:chemical:sps30 Supress some switch fallthrough warnings.

Jules Irenge (4):
      staging: mt7621-eth: Add SPDX license identifier
      staging: mt7621-eth: Remove license boilerplate text
      staging: mt7621-dma: add SPDX GPL-2.0+ license identifier
      staging: mt7621-dma: remove license boilerplate text

Julia Lawall (1):
      staging: rtl8192e: reduce indentation

K Hodges (2):
      staging: android: formatting change in ashmem.c
      staging: wlan-ng: formatting change in cfg80211.c

Kai-Heng Feng (2):
      staging: rtl8712u: Remove dummy reset-resume callback
      staging: rtl8712u: Fix suspend and resume callbacks

Kangjie Lu (2):
      iio: ad9523: fix a missing check of return value
      staging: rtlwifi: rtl8822b: fix a missing check of alloc_skb

Krzysztof Kozlowski (2):
      iio: adc: exynos-adc: Fix NULL pointer exception on unbind
      iio: adc: exynos-adc: Use proper number of channels for Exynos4x12

Lorenzo Bianconi (1):
      dt-bindings: iio: pressure: add LPS22HH bindings

Luciana da Costa Marques (1):
      iio:accel:adxl345: Change alignment to match paranthesis

Madhumitha Prabakaran (7):
      Staging: vt6655: Alignment should match open parenthesis
      Staging: vt6655: Alignment should match open parenthesis
      Staging: vt6655: Alignment of function declaration
      Staging: vt6655: Align a function declaration
      Staging: vt6655: Modify comment style for SPDX-License-Identifier
      Staging: vt6655: Modify comment style of SPDX License Identifier
      Staging: vt6655: Align a static function declaration

Marcelo Schmitt (3):
      staging: iio: ad5933: change regulator binging for vref
      staging: iio: ad5933: use clock framework for clock reference
      staging: iio: ad5933: add binding doc for ad5933

Marko Stankovic (1):
      staging: wilc1000: make function wilc_get_stats_async static

Martin Blumenstingl (2):
      dt-bindings: iio: adc: meson-saradc: update temperature sensor support
      iio: adc: meson-saradc: enable the temperature sensor two more SoCs

Martin Kelly (6):
      iio:bmi160: add SPDX identifiers
      iio:bmi160: add drdy interrupt support
      dt-bindings: fix incorrect bmi160 IRQ note
      dt-bindings: bmi160 document open-drain property
      iio:bmi160: use iio_pollfunc_store_time
      iio:bmi160: use if (ret) instead of if (ret < 0)

Masahiro Yamada (1):
      staging: prefix header search paths with $(srctree)/

Matt McCoy (1):
      staging: ks7010: remove unnecessary parentheses

Matteo Croce (1):
      staging: comedi: fix typo

Michael Straube (24):
      staging: fsl-dpaa2: fix SPDX identifiers in header files
      staging: goldfish: remove GPL boiler plate text
      staging: gs_fpgaboot: add SPDX identifiers
      staging: gs_fpgaboot: cleanup alignment issue - style
      staging: rtl8188eu: remove unnecessary parentheses in os_intfs.c
      staging: rtl8188eu: cleanup declarations in os_intfs.c
      staging: rtl8188eu: add spaces around operators in os_intfs.c
      staging: rtl8188eu: add spaces around operators in mlme_linux.c
      staging: rtl8188eu: cleanup indenting issue in mlme_linux.c
      staging: rtl8188eu: cleanup comments in mlme_linux.c
      staging: rtl8188eu: remove unnecessary initializations
      staging: rtl8188eu: cleanup declarations in mlme_linux.c
      staging: rtl8188eu: remove unncessary asignment to cleanup long line
      staging: rtl8188eu: &array[0] -> array
      staging: rtl8188eu: refactor rtw_reset_securitypriv()
      staging: rtl8188eu: cleanup ODM_CmnInfoPtrArrayHook()
      staging: rtl8188eu: remove unnecessary parentheses in rtl8188e_cmd.c
      staging: rtl8188eu: cleanup declarations in rtl8188e_cmd.c
      staging: rtl8188eu: remove blank line between declarations
      staging: rtl8188eu: remove unused function declarations
      staging: rtl8188eu: add spaces around '*' in rtl8188e_cmd.c
      staging: rtl8188eu: cleanup comparsions to NULL in rtl8188eu_xmit.c
      staging: rtl8188eu: remove unused enum P2P_PROTO_WK_ID
      staging: rtl8188eu: remove unused P2P_PRIVATE_IOCTL_SET_LEN

Michiel Schuurmans (1):
      Staging: rtl8192e: Replaced spaces with tab.

Mircea Caprioru (1):
      iio: dac: ad5686: Add support for AD5674R/AD5679R

Nathan Chancellor (1):
      staging: rtlwifi: Use proper enum for return in halmac_parse_psd_data_88xx

Nicholas Mc Guire (1):
      staging: r8822be: check kzalloc return or bail

Nishad Kamdar (8):
      staging: greybus: gpio: switch GPIO portions to use GPIOLIB_IRQCHIP
      staging: greybus: arche-apb-ctrl.c: Switch to the gpio descriptor interface
      staging: greybus: arche-platform: Switch to the gpio descriptor interface
      Staging: emxx_udc: Switch to the gpio descriptor interface
      Staging: fbtft: Switch to the gpio descriptor interface
      staging: mt7621-pinctrl: Remove space after cast
      staging: mt7621-pinctrl: Test devm_kzalloc for failure while improving the code
      staging: vt6656: Use the correct style for SPDX license Identifier

Oscar Gomez Fuente (1):
      staging: rtl8192e: Fix space and suspect issue

Prashanth Kumar KR (1):
      staging: rtl8712: Fix indentation issue

Prathamesh Deshpande (1):
      staging: wlan-ng: prism2fw.c: Fix "Possible unnecessary 'out of memory' message" checkpatch.pl warning"

Qing Xia (1):
      staging: android: ion: fix sys heap pool's gfp_flags

Randolph Maaﬂen (2):
      dt-bindings: iio: imu: add icm20602 bindings to mpu6050
      iio: imu: mpu6050: Add support for the ICM 20602 IMU

Ricardo Ribalda Delgado (3):
      iio: adc: ad7476: Add support for TI ADS786X ADCs
      iio:dac:ti-dac7612: Add driver for Texas Instruments DAC7612
      iio:dac:dac7612: device tree bindings

Robert Eshleman (2):
      iio: light: add driver for MAX44009
      dt-bindings: iio: light: Add max44009

Samuel Thibault (1):
      staging: speakup: Note that simple_strtoul can't simply be replaced by kstrtoul

Sandesh Kenjana Ashok (1):
      staging: comedi: comedi_fops.c: Remove redundant blank line

Sebastien Bourdelin (2):
      iio: chemical: bme680: Add device-tree support
      dt-bindings: iio: chemical: Add bindings for bme680

Sergio Paracuellos (16):
      staging: mt7621-pinctrl: use pinconf-generic for 'dt_node_to_map' and 'dt_free_map'
      staging: mt7621-dts: use standard 'groups' instead of 'group' for pinctrl bindings
      staging: mt7621-pci-phy: add new driver for phy part of mt7621-pci
      staging: mt7621-pci: handle phy using new generic phy 'pci-mt7621-phy' driver
      staging: mt7621-dts: add pci-phy related bindings to board's device tree
      staging: mt7621-pci-phy: dt-bindings: add bindings for Mediatek MT7621 Pcie PHY
      staging: mt7621-pci: use PCI definitions instead of hardcode values
      staging: mt7621-pci: update driver's TODO file
      staging: mt7621-dts: fix pci phy register addresses
      staging: mt7621-pci-phy: use 'module_init' instead of 'arch_initcall'
      staging: mt7621-pci: add reset control for general pcie reset
      staging: mt7621-dts: add general pcie reset line to pcie bindings
      staging: mt7621-pci: remove not used definitions
      staging: mt7621-pci: replace spaces with tabs in comment
      staging: mt7621-pci: remove two register writes
      staging: mt7621-pci: reverse condition to check for enabled port

Sheng Yong (1):
      staging: erofs: fix memleak of inode's shared xattr array

Shreeya Patel (1):
      Staging: iio: adt7316: Add all irq related code in adt7316_irq_setup()

Sidong Yang (1):
      staging: erofs: Add identifier for function definition arguments

Slawomir Stepien (2):
      staging: iio: adc: ad7280a: split ad7280_channel_init() to more functions
      staging: iio: adc: ad7280a: split ad7280_attr_init() to more functions

Stefan Popa (15):
      staging: iio: adc: ad7606: Use wait-for-completion handler
      staging: iio: adc: ad7606: Use devm functions in probe
      staging: iio: adc: ad7606: Use find_closest() macro
      staging: iio: adc: ad7606: Use vendor prefix for DT properties
      staging: iio: adc: ad7606: Add OF device ID table
      staging: iio: adc: ad7606: Simplify the Kconfing menu
      staging: iio: adc: ad7606: Use SPDX identifier
      staging: iio: adc: ad7606: Add support for threaded irq
      staging: iio: adc: ad7606: Misc style fixes (no functional change)
      staging: iio: adc: ad7606: Move out of staging
      dt-bindings: iio: adc: Add docs for AD7606 ADC
      iio: adc: Add AD7768-1 ADC basic support
      dt-bindings: iio: adc: Add docs for AD7768-1
      drivers: iio: dac: Fix wrong license for ADI drivers
      iio: adc: ad7768-1: Add support for setting the sampling frequency

Stefan Roese (9):
      staging: spi: mt7621: Switch to SPDX identifier
      staging: spi: mt7621: Clean up excessive header usage
      staging: spi: mt7621: Add return code check on device_reset()
      staging: spi: mt7621: Remove superfluous SPI_BPW_MASK definition
      staging: spi: mt7621: Minor cosmetic changes
      staging: spi: mt7621: Use recommended comment style
      staging: spi: mt7621: Sort register definitions
      staging: spi: mt7621: Use macros instead of hardcoded values
      staging: spi: mt7621: Remove superfluous pre-declaration of struct mt7621_spi

Stephen Martin (2):
      staging: rtw_ieee80211: fix constant comparison warning
      staging: rtl8188eu: fix bad indentation for conditional statement

Sumit Pundir (1):
      staging: octeon-usb: fix misspelled "re-enable"

Tetsuo Handa (2):
      staging: android: ashmem: Don't call fallocate() with ashmem_mutex held.
      staging: android: ashmem: Avoid range_alloc() allocation with ashmem_mutex held.

Tomasz Duszynski (9):
      iio: add IIO_MASSCONCENTRATION channel type
      iio: chemical: add support for Sensirion SPS30 sensor
      dt-bindings: iio: chemical: sps30: add device tree support
      iio: chemical: sps30: add support for self cleaning
      iio: chemical: sps30: allow changing self cleaning period
      iio: chemical: sps30: remove printk format specifier
      iio: chemical: add support for Plantower PMS7003 sensor
      dt-bindings: add Plantower to the vendor prefixes
      dt-bindings: iio: chemical: pms7003: add device tree support

Tomer Maimon (3):
      dt-binding: iio: add NPCM ADC documentation
      iio: adc: add NPCM ADC driver
      dt-binding: iio: remove rst node from NPCM ADC document

Wentao Cai (1):
      Staging: ks7010: Replace typecast to int

William Mitchell Jr (1):
      staging: comedi: cb_pcimdas.c: fixed an alignment coding style issue

Yue Haibing (1):
      staging: gasket: interrupt: remove unused including <linux/version.h>

YueHaibing (7):
      iio: imu: st_lsm6dsx: remove set but not used variable ''
      staging: wilc1000: remove set but not used variable 'msa'
      staging: rtl8712: drop pointless static qualifier in r8712_efuse_pg_packet_write()
      staging: rtl8192e: Remove set but not used variables 'broad_addr, stype'
      staging: mt7621-mmc: Remove unused including <linux/version.h>
      staging: rtlwifi: Remove set but not used variables 'dataempty, hoffset'
      staging: rtl8723bs: Remove duplicated include from drv_types.h

mario tesi (1):
      iio:st_pressure:initial lps22hh sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |   21 +-
 Documentation/ABI/testing/sysfs-bus-iio-sps30      |   28 +
 .../devicetree/bindings/iio/accel/mma8452.txt      |    4 +
 .../devicetree/bindings/iio/adc/adi,ad7606.txt     |   65 +
 .../devicetree/bindings/iio/adc/adi,ad7768-1.txt   |   41 +
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |    4 +
 .../devicetree/bindings/iio/adc/ingenic,adc.txt    |   48 +
 .../bindings/{staging => }/iio/adc/lpc32xx-adc.txt |    0
 .../bindings/iio/adc/nuvoton,npcm-adc.txt          |   24 +
 .../bindings/iio/adc/samsung,exynos-adc.txt        |    4 +-
 .../devicetree/bindings/iio/adc/ti-ads124s08.txt   |   25 +
 .../devicetree/bindings/iio/chemical/bme680.txt    |   11 +
 .../bindings/iio/chemical/plantower,pms7003.txt    |   20 +
 .../bindings/iio/chemical/sensirion,sgp30.txt      |   15 +
 .../bindings/iio/chemical/sensirion,sps30.txt      |   12 +
 .../devicetree/bindings/iio/dac/ti,dac7612.txt     |   28 +
 .../bindings/iio/impedance-analyzer/ad5933.txt     |   26 +
 .../devicetree/bindings/iio/imu/bmi160.txt         |    6 +-
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |    1 +
 .../devicetree/bindings/iio/light/max44009.txt     |   24 +
 .../devicetree/bindings/iio/st-sensors.txt         |    1 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |   28 +-
 drivers/iio/accel/adxl345_core.c                   |    4 +-
 drivers/iio/accel/mma8452.c                        |  105 +-
 drivers/iio/accel/st_accel_core.c                  |  171 +-
 drivers/iio/adc/Kconfig                            |   80 +-
 drivers/iio/adc/Makefile                           |    7 +
 drivers/iio/adc/ad7476.c                           |   20 +
 drivers/{staging => }/iio/adc/ad7606.c             |  272 +-
 drivers/{staging => }/iio/adc/ad7606.h             |   17 +-
 drivers/{staging => }/iio/adc/ad7606_par.c         |   46 +-
 drivers/{staging => }/iio/adc/ad7606_spi.c         |   35 +-
 drivers/iio/adc/ad7768-1.c                         |  655 +++
 drivers/iio/adc/exynos_adc.c                       |   19 +-
 drivers/iio/adc/ingenic-adc.c                      |  364 ++
 drivers/iio/adc/lpc32xx_adc.c                      |   15 +-
 drivers/iio/adc/meson_saradc.c                     |   33 +
 drivers/iio/adc/npcm_adc.c                         |  335 ++
 drivers/iio/adc/ti-ads124s08.c                     |  376 ++
 drivers/iio/adc/xilinx-xadc-core.c                 |    4 +-
 drivers/iio/chemical/Kconfig                       |   21 +
 drivers/iio/chemical/Makefile                      |    3 +
 drivers/iio/chemical/bme680_i2c.c                  |    7 +
 drivers/iio/chemical/bme680_spi.c                  |    8 +
 drivers/iio/chemical/pms7003.c                     |  340 ++
 drivers/iio/chemical/sgp30.c                       |  591 +++
 drivers/iio/chemical/sps30.c                       |  548 ++
 drivers/iio/dac/Kconfig                            |   16 +-
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5686-spi.c                       |    9 +-
 drivers/iio/dac/ad5686.c                           |   44 +-
 drivers/iio/dac/ad5686.h                           |    4 +-
 drivers/iio/dac/ad5696-i2c.c                       |    2 +-
 drivers/iio/dac/ad5758.c                           |    2 +-
 drivers/iio/dac/ti-dac7612.c                       |  184 +
 drivers/iio/frequency/ad9523.c                     |    7 +-
 drivers/iio/imu/bmi160/bmi160.h                    |   11 +
 drivers/iio/imu/bmi160/bmi160_core.c               |  317 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    5 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |    4 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |    8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   31 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    8 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   12 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |    2 -
 drivers/iio/industrialio-core.c                    |    5 +
 drivers/iio/light/Kconfig                          |   10 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/isl29018.c                       |   46 +-
 drivers/iio/light/max44009.c                       |  555 ++
 drivers/iio/magnetometer/mag3110.c                 |   94 +-
 drivers/iio/pressure/Kconfig                       |    2 +-
 drivers/iio/pressure/st_pressure.h                 |    2 +
 drivers/iio/pressure/st_pressure_core.c            |   69 +
 drivers/iio/pressure/st_pressure_i2c.c             |    5 +
 drivers/iio/pressure/st_pressure_spi.c             |    5 +
 drivers/staging/Kconfig                            |    6 +-
 drivers/staging/Makefile                           |   13 +-
 drivers/staging/android/ashmem.c                   |   70 +-
 drivers/staging/android/ion/Makefile               |    2 +-
 drivers/staging/android/ion/ion-ioctl.c            |   98 -
 drivers/staging/android/ion/ion.c                  |   84 +-
 drivers/staging/android/ion/ion.h                  |   42 +-
 drivers/staging/android/ion/ion_carveout_heap.c    |   19 +-
 drivers/staging/android/ion/ion_chunk_heap.c       |   25 +-
 drivers/staging/android/ion/ion_cma_heap.c         |    6 +-
 drivers/staging/android/ion/ion_heap.c             |    8 +-
 drivers/staging/android/ion/ion_page_pool.c        |    2 +-
 drivers/staging/android/ion/ion_system_heap.c      |   10 +-
 drivers/staging/android/uapi/ion.h                 |    2 +-
 drivers/staging/android/vsoc.c                     |    1 -
 drivers/staging/comedi/comedi_fops.c               |    3 +-
 drivers/staging/comedi/drivers/cb_pcimdas.c        |    6 +-
 drivers/staging/comedi/drivers/ni_660x.c           |    1 +
 drivers/staging/comedi/drivers/ni_pcidio.c         |  444 +-
 drivers/staging/comedi/drivers/ni_tio.c            |   71 +-
 drivers/staging/comedi/drivers/ni_tio.h            |    4 +-
 drivers/staging/comedi/drivers/usbduxfast.c        |    2 +-
 drivers/staging/emxx_udc/emxx_udc.c                |   31 +-
 drivers/staging/emxx_udc/emxx_udc.h                |    2 +
 .../erofs/Documentation/filesystems/erofs.txt      |  208 +
 drivers/staging/erofs/Makefile                     |    2 +-
 drivers/staging/erofs/data.c                       |   37 +-
 drivers/staging/erofs/dir.c                        |   12 +-
 drivers/staging/erofs/inode.c                      |   41 +-
 drivers/staging/erofs/internal.h                   |  147 +-
 drivers/staging/erofs/namei.c                      |  194 +-
 drivers/staging/erofs/super.c                      |   29 +-
 drivers/staging/erofs/unzip_vle.c                  |  165 +-
 drivers/staging/erofs/unzip_vle.h                  |   23 +-
 drivers/staging/erofs/unzip_vle_lz4.c              |   21 +-
 drivers/staging/erofs/utils.c                      |   58 +-
 drivers/staging/erofs/xattr.c                      |  115 +-
 drivers/staging/erofs/xattr.h                      |   10 +-
 drivers/staging/fbtft/fb_agm1264k-fl.c             |   52 +-
 drivers/staging/fbtft/fb_bd663474.c                |    6 +-
 drivers/staging/fbtft/fb_ili9163.c                 |    6 +-
 drivers/staging/fbtft/fb_ili9320.c                 |    2 +-
 drivers/staging/fbtft/fb_ili9325.c                 |    6 +-
 drivers/staging/fbtft/fb_ili9340.c                 |    2 +-
 drivers/staging/fbtft/fb_pcd8544.c                 |    4 +-
 drivers/staging/fbtft/fb_ra8875.c                  |    4 +-
 drivers/staging/fbtft/fb_s6d1121.c                 |    6 +-
 drivers/staging/fbtft/fb_sh1106.c                  |    2 +-
 drivers/staging/fbtft/fb_ssd1289.c                 |    6 +-
 drivers/staging/fbtft/fb_ssd1305.c                 |    4 +-
 drivers/staging/fbtft/fb_ssd1306.c                 |    4 +-
 drivers/staging/fbtft/fb_ssd1325.c                 |    6 +-
 drivers/staging/fbtft/fb_ssd1331.c                 |   10 +-
 drivers/staging/fbtft/fb_ssd1351.c                 |    4 +-
 drivers/staging/fbtft/fb_tinylcd.c                 |    2 +-
 drivers/staging/fbtft/fb_tls8204.c                 |    6 +-
 drivers/staging/fbtft/fb_uc1611.c                  |    4 +-
 drivers/staging/fbtft/fb_uc1701.c                  |    6 +-
 drivers/staging/fbtft/fb_upd161704.c               |    6 +-
 drivers/staging/fbtft/fb_watterott.c               |    4 +-
 drivers/staging/fbtft/fbtft-bus.c                  |    6 +-
 drivers/staging/fbtft/fbtft-core.c                 |  178 +-
 drivers/staging/fbtft/fbtft-io.c                   |   26 +-
 drivers/staging/fbtft/fbtft.h                      |   21 +-
 drivers/staging/fbtft/fbtft_device.c               |  344 +-
 drivers/staging/fbtft/flexfb.c                     |   12 +-
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h         |    2 +-
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h             |    2 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            |    3 +
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h            |    2 +-
 drivers/staging/fwserial/fwserial.c                |    1 +
 drivers/staging/gasket/gasket_interrupt.c          |    1 -
 drivers/staging/goldfish/goldfish_audio.c          |   10 -
 drivers/staging/greybus/Kconfig                    |    1 +
 drivers/staging/greybus/TODO                       |    2 -
 drivers/staging/greybus/arche-apb-ctrl.c           |  152 +-
 drivers/staging/greybus/arche-platform.c           |  124 +-
 drivers/staging/greybus/audio_topology.c           |    1 -
 drivers/staging/greybus/bundle.c                   |    2 +-
 drivers/staging/greybus/connection.h               |    2 +-
 drivers/staging/greybus/control.c                  |    1 -
 drivers/staging/greybus/core.c                     |    2 +-
 drivers/staging/greybus/gpio.c                     |  156 +-
 drivers/staging/gs_fpgaboot/gs_fpgaboot.c          |   12 +-
 drivers/staging/gs_fpgaboot/gs_fpgaboot.h          |   12 +-
 drivers/staging/gs_fpgaboot/io.c                   |   16 +-
 drivers/staging/gs_fpgaboot/io.h                   |   12 +-
 drivers/staging/iio/adc/Kconfig                    |   34 -
 drivers/staging/iio/adc/Makefile                   |    4 -
 drivers/staging/iio/adc/ad7280a.c                  |  243 +-
 drivers/staging/iio/adc/ad7816.c                   |    7 +-
 drivers/staging/iio/addac/adt7316-i2c.c            |    6 +-
 drivers/staging/iio/addac/adt7316-spi.c            |    4 +-
 drivers/staging/iio/addac/adt7316.c                |  143 +-
 drivers/staging/iio/cdc/Kconfig                    |   10 -
 drivers/staging/iio/cdc/Makefile                   |    1 -
 drivers/staging/iio/cdc/ad7152.c                   |  552 --
 drivers/staging/iio/frequency/ad9834.c             |   54 +-
 drivers/staging/iio/frequency/ad9834.h             |   28 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   57 +-
 drivers/staging/ks7010/Makefile                    |    2 +-
 drivers/staging/ks7010/TODO                        |    2 -
 drivers/staging/ks7010/ks_hostif.c                 |  119 +-
 drivers/staging/ks7010/ks_wlan_net.c               |    2 +-
 drivers/staging/ks7010/michael_mic.c               |  127 -
 drivers/staging/ks7010/michael_mic.h               |   21 -
 drivers/staging/media/davinci_vpfe/Makefile        |    2 +-
 drivers/staging/most/Makefile                      |    2 +-
 drivers/staging/most/cdev/Makefile                 |    2 +-
 drivers/staging/most/cdev/cdev.c                   |    5 +-
 drivers/staging/most/dim2/Makefile                 |    2 +-
 drivers/staging/most/i2c/Makefile                  |    2 +-
 drivers/staging/most/net/Makefile                  |    2 +-
 drivers/staging/most/sound/Makefile                |    2 +-
 drivers/staging/most/usb/Makefile                  |    2 +-
 drivers/staging/most/video/Makefile                |    2 +-
 drivers/staging/mt7621-dma/Kconfig                 |    6 -
 drivers/staging/mt7621-dma/Makefile                |    1 -
 drivers/staging/mt7621-dma/mtk-hsdma.c             |   11 +-
 drivers/staging/mt7621-dts/gbpc1.dts               |    4 +-
 drivers/staging/mt7621-dts/mt7621.dtsi             |   59 +-
 drivers/staging/mt7621-eth/ethtool.c               |    1 +
 drivers/staging/mt7621-eth/ethtool.h               |   11 +-
 drivers/staging/mt7621-mmc/Kconfig                 |    2 +-
 drivers/staging/mt7621-mmc/dbg.c                   |    1 -
 drivers/staging/mt7621-mmc/mt6575_sd.h             |    2 +-
 drivers/staging/mt7621-pci-phy/Kconfig             |    7 +
 drivers/staging/mt7621-pci-phy/Makefile            |    1 +
 drivers/staging/mt7621-pci-phy/TODO                |    4 +
 .../mt7621-pci-phy/mediatek,mt7621-pci-phy.txt     |   54 +
 drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c    |  387 ++
 drivers/staging/mt7621-pci/Makefile                |    2 +-
 drivers/staging/mt7621-pci/TODO                    |    8 -
 drivers/staging/mt7621-pci/pci-mt7621.c            |  300 +-
 drivers/staging/mt7621-pinctrl/Kconfig             |    1 +
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c    |   49 +-
 drivers/staging/mt7621-spi/spi-mt7621.c            |   72 +-
 drivers/staging/netlogic/Kconfig                   |    2 +-
 drivers/staging/netlogic/platform_net.c            |   51 +-
 drivers/staging/netlogic/platform_net.h            |   32 +-
 drivers/staging/netlogic/xlr_net.c                 |   31 +-
 drivers/staging/netlogic/xlr_net.h                 |   33 +-
 drivers/staging/octeon-usb/octeon-hcd.h            |    2 +-
 drivers/staging/ralink-gdma/Kconfig                |    6 +
 drivers/staging/ralink-gdma/Makefile               |    3 +
 .../{mt7621-dma => ralink-gdma}/ralink-gdma.c      |    6 +-
 drivers/staging/rtl8188eu/core/rtw_ap.c            |    8 +-
 drivers/staging/rtl8188eu/core/rtw_cmd.c           |   12 +-
 drivers/staging/rtl8188eu/core/rtw_efuse.c         |    4 +-
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |   10 +-
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c     |   12 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |   44 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |   38 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c     |   18 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |    2 +-
 drivers/staging/rtl8188eu/hal/odm.c                |   11 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c       |   67 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c     |    4 +-
 drivers/staging/rtl8188eu/include/odm.h            |    1 -
 drivers/staging/rtl8188eu/include/odm_hwconfig.h   |    9 -
 drivers/staging/rtl8188eu/include/wifi.h           |   12 -
 drivers/staging/rtl8188eu/include/wlan_bssdef.h    |    6 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |   34 +-
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c      |   72 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c        |   26 +-
 drivers/staging/rtl8188eu/os_dep/rtw_android.c     |    2 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |    6 +-
 drivers/staging/rtl8192e/dot11d.c                  |  120 +-
 drivers/staging/rtl8192e/dot11d.h                  |   77 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |    8 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   23 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |    2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |    8 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |    6 +-
 drivers/staging/rtl8192e/rtllib.h                  |    6 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |    2 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |    4 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |   22 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |    4 +-
 drivers/staging/rtl8192u/Makefile                  |    2 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   24 +-
 drivers/staging/rtl8712/ieee80211.c                |    2 +-
 drivers/staging/rtl8712/rtl8712_efuse.c            |    2 +-
 drivers/staging/rtl8712/rtl8712_led.c              |    6 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |    2 +-
 drivers/staging/rtl8712/rtl871x_recv.c             |    6 +-
 drivers/staging/rtl8712/rtl871x_sta_mgt.c          |    2 +-
 drivers/staging/rtl8712/rtl871x_xmit.c             |    8 +-
 drivers/staging/rtl8712/usb_intf.c                 |   16 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |    8 -
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |    2 +-
 drivers/staging/rtl8723bs/include/drv_types.h      |    1 -
 drivers/staging/rtlwifi/Kconfig                    |    2 +-
 drivers/staging/rtlwifi/efuse.c                    |    6 +-
 .../rtlwifi/halmac/halmac_88xx/halmac_func_88xx.c  |    5 +-
 drivers/staging/rtlwifi/pci.h                      |    3 +-
 drivers/staging/rtlwifi/phydm/phydm_rainfo.c       |    2 +-
 drivers/staging/rtlwifi/rtl8822be/fw.c             |    2 +
 drivers/staging/rts5208/ms.c                       |    5 +-
 drivers/staging/rts5208/sd.c                       |    7 +-
 drivers/staging/sm750fb/ddk750_display.c           |    6 +-
 drivers/staging/speakup/Kconfig                    |   32 +-
 drivers/staging/speakup/kobjects.c                 |    2 +
 drivers/staging/speakup/main.c                     |   14 +-
 drivers/staging/speakup/speakup_decext.c           |    3 +-
 drivers/staging/speakup/speakup_dectlk.c           |    3 +-
 drivers/staging/speakup/speakup_soft.c             |    4 +-
 drivers/staging/speakup/spk_priv_keyinfo.h         |    9 +-
 drivers/staging/speakup/spk_ttyio.c                |   20 +-
 drivers/staging/speakup/varhandlers.c              |    4 +-
 drivers/staging/unisys/visorhba/Makefile           |    3 +-
 drivers/staging/unisys/visornic/Makefile           |    3 +-
 drivers/staging/unisys/visornic/visornic_main.c    |    4 +-
 .../staging/vc04_services/bcm2835-audio/Makefile   |    3 +-
 .../staging/vc04_services/bcm2835-camera/Makefile  |    2 +-
 drivers/staging/vt6655/baseband.c                  |   10 +-
 drivers/staging/vt6655/baseband.h                  |    2 +-
 drivers/staging/vt6655/card.c                      |   16 +-
 drivers/staging/vt6655/card.h                      |    2 +-
 drivers/staging/vt6655/device_main.c               |    4 +-
 drivers/staging/vt6656/key.c                       |    4 +-
 drivers/staging/vt6656/mac.h                       |    2 +-
 drivers/staging/wilc1000/Makefile                  |    2 +-
 drivers/staging/wilc1000/host_interface.c          | 1164 ++---
 drivers/staging/wilc1000/host_interface.h          |  165 +-
 .../staging/wilc1000/{linux_mon.c => wilc_mon.c}   |   77 +-
 .../wilc1000/{linux_wlan.c => wilc_netdev.c}       |  430 +-
 drivers/staging/wilc1000/wilc_sdio.c               |  187 +-
 drivers/staging/wilc1000/wilc_spi.c                |    4 +-
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c  |  644 +--
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.h  |    7 +-
 drivers/staging/wilc1000/wilc_wfi_netdevice.h      |   14 +-
 drivers/staging/wilc1000/wilc_wlan.c               |   52 +-
 drivers/staging/wilc1000/wilc_wlan.h               |   38 +-
 drivers/staging/wilc1000/wilc_wlan_cfg.c           |   39 +-
 drivers/staging/wilc1000/wilc_wlan_if.h            |   40 -
 drivers/staging/wlan-ng/Kconfig                    |    2 +-
 drivers/staging/wlan-ng/cfg80211.c                 |    3 +-
 drivers/staging/wlan-ng/prism2fw.c                 |    5 +-
 drivers/staging/xgifb/Kconfig                      |   11 -
 drivers/staging/xgifb/Makefile                     |    4 -
 drivers/staging/xgifb/TODO                         |   13 -
 drivers/staging/xgifb/XGI_main.h                   |  365 --
 drivers/staging/xgifb/XGI_main_26.c                | 2084 --------
 drivers/staging/xgifb/XGIfb.h                      |  109 -
 drivers/staging/xgifb/vb_def.h                     |  257 -
 drivers/staging/xgifb/vb_init.c                    | 1367 -----
 drivers/staging/xgifb/vb_init.h                    |    6 -
 drivers/staging/xgifb/vb_setmode.c                 | 5528 --------------------
 drivers/staging/xgifb/vb_setmode.h                 |   24 -
 drivers/staging/xgifb/vb_struct.h                  |  165 -
 drivers/staging/xgifb/vb_table.h                   | 2513 ---------
 drivers/staging/xgifb/vb_util.h                    |   46 -
 drivers/staging/xgifb/vgatypes.h                   |   51 -
 include/dt-bindings/iio/adc/ingenic,adc.h          |   10 +
 include/linux/iio/common/st_sensors.h              |    1 +
 include/uapi/linux/iio/types.h                     |    7 +
 tools/iio/iio_event_monitor.c                      |   14 +
 336 files changed, 9606 insertions(+), 18624 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sps30
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
 rename Documentation/devicetree/bindings/{staging => }/iio/adc/lpc32xx-adc.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
 create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt
 rename drivers/{staging => }/iio/adc/ad7606.c (73%)
 rename drivers/{staging => }/iio/adc/ad7606.h (88%)
 rename drivers/{staging => }/iio/adc/ad7606_par.c (75%)
 rename drivers/{staging => }/iio/adc/ad7606_spi.c (67%)
 create mode 100644 drivers/iio/adc/ad7768-1.c
 create mode 100644 drivers/iio/adc/ingenic-adc.c
 create mode 100644 drivers/iio/adc/npcm_adc.c
 create mode 100644 drivers/iio/adc/ti-ads124s08.c
 create mode 100644 drivers/iio/chemical/pms7003.c
 create mode 100644 drivers/iio/chemical/sgp30.c
 create mode 100644 drivers/iio/chemical/sps30.c
 create mode 100644 drivers/iio/dac/ti-dac7612.c
 create mode 100644 drivers/iio/light/max44009.c
 delete mode 100644 drivers/staging/android/ion/ion-ioctl.c
 create mode 100644 drivers/staging/erofs/Documentation/filesystems/erofs.txt
 delete mode 100644 drivers/staging/iio/cdc/ad7152.c
 delete mode 100644 drivers/staging/ks7010/michael_mic.c
 delete mode 100644 drivers/staging/ks7010/michael_mic.h
 create mode 100644 drivers/staging/mt7621-pci-phy/Kconfig
 create mode 100644 drivers/staging/mt7621-pci-phy/Makefile
 create mode 100644 drivers/staging/mt7621-pci-phy/TODO
 create mode 100644 drivers/staging/mt7621-pci-phy/mediatek,mt7621-pci-phy.txt
 create mode 100644 drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
 create mode 100644 drivers/staging/ralink-gdma/Kconfig
 create mode 100644 drivers/staging/ralink-gdma/Makefile
 rename drivers/staging/{mt7621-dma => ralink-gdma}/ralink-gdma.c (99%)
 rename drivers/staging/wilc1000/{linux_mon.c => wilc_mon.c} (78%)
 rename drivers/staging/wilc1000/{linux_wlan.c => wilc_netdev.c} (74%)
 delete mode 100644 drivers/staging/xgifb/Kconfig
 delete mode 100644 drivers/staging/xgifb/Makefile
 delete mode 100644 drivers/staging/xgifb/TODO
 delete mode 100644 drivers/staging/xgifb/XGI_main.h
 delete mode 100644 drivers/staging/xgifb/XGI_main_26.c
 delete mode 100644 drivers/staging/xgifb/XGIfb.h
 delete mode 100644 drivers/staging/xgifb/vb_def.h
 delete mode 100644 drivers/staging/xgifb/vb_init.c
 delete mode 100644 drivers/staging/xgifb/vb_init.h
 delete mode 100644 drivers/staging/xgifb/vb_setmode.c
 delete mode 100644 drivers/staging/xgifb/vb_setmode.h
 delete mode 100644 drivers/staging/xgifb/vb_struct.h
 delete mode 100644 drivers/staging/xgifb/vb_table.h
 delete mode 100644 drivers/staging/xgifb/vb_util.h
 delete mode 100644 drivers/staging/xgifb/vgatypes.h
 create mode 100644 include/dt-bindings/iio/adc/ingenic,adc.h
