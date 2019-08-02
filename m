Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E16C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3702073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbfHBE4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 00:56:18 -0400
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:40181 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732224AbfHBE4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:56:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 534B3181D3368;
        Fri,  2 Aug 2019 04:56:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rifle31_707bd3dce0b09
X-Filterd-Recvd-Size: 33822
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Aug 2019 04:56:12 +0000 (UTC)
Message-ID: <960ef8af3f75114d5a8a30ba67bb02afef4d95c4.camel@perches.com>
Subject: Re: linux kernel sources: more misspellings/tyops of <foo>iton words
From:   Joe Perches <joe@perches.com>
To:     kernel-janitors <kernel-janitors@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        Jiri Kosina <trivial@kernel.org>
Date:   Thu, 01 Aug 2019 21:56:11 -0700
In-Reply-To: <7a06b8e9acf87a871642166370ac50ec6c734ce8.camel@perches.com>
References: <7a06b8e9acf87a871642166370ac50ec6c734ce8.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 21:23 -0700, Joe Perches wrote:
> If any feels like it, here are some more typos from:
> 
> $ git grep -P '\b\w+itons?' | grep -ohP '\b\w+itons?' | sort | uniq -c | sort -rn
>       7 additon
>       6 definitons
>       5 Prediciton
>       5 instruciton
>       4 conditon
>       3 partititon
>       3 notificaiton
>       3 implementaiton
>       3 definiton
>       3 Additon
>       2 veriton
>       2 unconditon
>       2 poriton
>       2 parititon
>       2 initializaiton
>       2 defininitons
>       2 conneciton
>       2 configuraiton
>       1 translaiton
>       1 Transisitons
>       1 traditon
>       1 quesiton
>       1 positon
>       1 posiiton
>       1 partiton
>       1 moniton
>       1 inspeciton
>       1 infomraiton
>       1 implicaitons
>       1 identificaiton
>       1 generaiton
>       1 encrypiton
>       1 destinaiton
>       1 declariton
>       1 confirmaiton
>       1 Configuraiton
>       1 conditons
>       1 calculaiton
>       1 applicaiton
>       1 allocaiton
> 

Here is a treewide -U0 diff of today's -next if
anyone wants to expand it by maintainer/subsystem
or apply it directly
---
 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt | 2 +-
 Documentation/networking/ila.txt                               | 2 +-
 arch/arc/kernel/signal.c                                       | 2 +-
 arch/arc/mm/cache.c                                            | 2 +-
 arch/arm/mach-s3c24xx/common-smdk.c                            | 2 +-
 arch/arm/mach-s3c24xx/common.c                                 | 2 +-
 arch/arm/mach-tegra/platsmp.c                                  | 2 +-
 arch/arm64/include/asm/assembler.h                             | 2 +-
 arch/ia64/include/asm/sn/clksupport.h                          | 2 +-
 arch/powerpc/include/asm/cpm1.h                                | 2 +-
 arch/powerpc/mm/init_64.c                                      | 2 +-
 arch/powerpc/platforms/cell/spufs/spu_restore_crt0.S           | 2 +-
 arch/sparc/kernel/traps_64.c                                   | 2 +-
 arch/x86/kvm/lapic.c                                           | 2 +-
 crypto/drbg.c                                                  | 2 +-
 drivers/gpu/drm/amd/include/atombios.h                         | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h             | 4 ++--
 drivers/gpu/drm/arm/malidp_hw.c                                | 2 +-
 drivers/gpu/drm/i915/intel_pm.c                                | 4 ++--
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c                | 2 +-
 drivers/media/platform/mtk-vcodec/venc_drv_if.h                | 2 +-
 drivers/media/platform/seco-cec/seco-cec.h                     | 2 +-
 drivers/message/fusion/lsi/mpi_ioc.h                           | 2 +-
 drivers/misc/genwqe/card_ddcb.c                                | 2 +-
 drivers/misc/pti.c                                             | 4 ++--
 drivers/misc/sgi-xp/xpc.h                                      | 2 +-
 drivers/misc/sgi-xp/xpc_sn2.c                                  | 2 +-
 drivers/mtd/spi-nor/spi-nor.c                                  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c       | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c           | 2 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.h                    | 2 +-
 drivers/net/wireless/ath/hw.c                                  | 2 +-
 drivers/net/wireless/ath/wcn36xx/hal.h                         | 2 +-
 drivers/nvme/host/fabrics.h                                    | 2 +-
 drivers/scsi/aic7xxx/aic79xx.h                                 | 2 +-
 drivers/scsi/aic7xxx/aic7xxx.h                                 | 2 +-
 drivers/scsi/esp_scsi.c                                        | 2 +-
 drivers/scsi/lpfc/lpfc_bsg.c                                   | 2 +-
 drivers/scsi/lpfc/lpfc_els.c                                   | 2 +-
 drivers/staging/fwserial/fwserial.c                            | 2 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c                      | 2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c                      | 2 +-
 drivers/target/target_core_transport.c                         | 2 +-
 drivers/usb/gadget/udc/net2272.c                               | 2 +-
 drivers/usb/misc/ldusb.c                                       | 2 +-
 drivers/usb/serial/io_usbvend.h                                | 2 +-
 drivers/video/fbdev/au1200fb.c                                 | 2 +-
 drivers/video/fbdev/da8xx-fb.c                                 | 2 +-
 include/linux/mfd/wm831x/regulator.h                           | 2 +-
 include/linux/tracepoint.h                                     | 2 +-
 include/rdma/rdma_vt.h                                         | 2 +-
 mm/memory.c                                                    | 2 +-
 mm/percpu-internal.h                                           | 2 +-
 sound/core/pcm_native.c                                        | 2 +-
 sound/isa/sb/emu8000_local.h                                   | 2 +-
 sound/pci/emu10k1/emu10k1_synth_local.h                        | 2 +-
 tools/lib/bpf/btf.c                                            | 2 +-
 tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json        | 2 +-
 tools/perf/pmu-events/arch/powerpc/power9/metrics.json         | 2 +-
 tools/perf/pmu-events/arch/x86/nehalemep/other.json            | 2 +-
 tools/perf/pmu-events/arch/x86/nehalemex/other.json            | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-dp/other.json        | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-sp/other.json        | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/other.json           | 2 +-
 tools/testing/selftests/bpf/test_sock_fields.c                 | 2 +-
 65 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
index 9afffbdf6e28..da5092c70932 100644
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
@@ -36 +36 @@ Optional Properties:
-- syna,disable-report-mask: Mask for disabling posiiton reporting. Used to
+- syna,disable-report-mask: Mask for disabling position reporting. Used to
diff --git a/Documentation/networking/ila.txt b/Documentation/networking/ila.txt
index a17dac9dc915..444216e48c04 100644
--- a/Documentation/networking/ila.txt
+++ b/Documentation/networking/ila.txt
@@ -253 +253 @@ MATCH indicates the incoming locator that must be matched to apply
-a the translaiton. LOC is the locator that overwrites the upper
+a the translation. LOC is the locator that overwrites the upper
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 3d57ed0d8535..d6f14f4bfcf4 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -262 +262 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
-		 * small optim to avoid unconditonally calling do_sigaltstack
+		 * small optim to avoid unconditionally calling do_sigaltstack
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index a2fbea3ee07c..4cd205adc8d6 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -222 +222 @@ void read_decode_cache_bcr(void)
- * The solution was to provide CDU with these additonal vaddr bits. These
+ * The solution was to provide CDU with these additional vaddr bits. These
diff --git a/arch/arm/mach-s3c24xx/common-smdk.c b/arch/arm/mach-s3c24xx/common-smdk.c
index 58e30cad386c..65980108817f 100644
--- a/arch/arm/mach-s3c24xx/common-smdk.c
+++ b/arch/arm/mach-s3c24xx/common-smdk.c
@@ -105 +105 @@ static struct platform_device smdk_led7 = {
-/* NAND parititon from 2.4.18-swl5 */
+/* NAND partition from 2.4.18-swl5 */
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 3dc029c2d2cb..cfc588922b02 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -147 +147 @@ static struct map_desc s3c_iodesc[] __initdata = {
-/* read cpu identificaiton code */
+/* read cpu identification code */
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index e6911a14c096..1f57e7c0feae 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -86 +86 @@ static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
-	 * the confirmaiton that the CPU is powered then removing
+	 * the confirmation that the CPU is powered then removing
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index e3a15c751b13..03a27d7316aa 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -375 +375 @@ alternative_endif
- * 	domain:		domain used in dsb instruciton
+ * 	domain:		domain used in dsb instruction
diff --git a/arch/ia64/include/asm/sn/clksupport.h b/arch/ia64/include/asm/sn/clksupport.h
index d340c365a824..5b7f35d5d42a 100644
--- a/arch/ia64/include/asm/sn/clksupport.h
+++ b/arch/ia64/include/asm/sn/clksupport.h
@@ -11 +11 @@
- * clock. The clock is monitonically increasing and can be accessed from any node
+ * clock. The clock is monotonically increasing and can be accessed from any node
diff --git a/arch/powerpc/include/asm/cpm1.h b/arch/powerpc/include/asm/cpm1.h
index a116fe931789..34a7df0849e0 100644
--- a/arch/powerpc/include/asm/cpm1.h
+++ b/arch/powerpc/include/asm/cpm1.h
@@ -484 +484 @@ typedef struct iic {
- * RISC Controller Configuration Register definitons
+ * RISC Controller Configuration Register definitions
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index a44f6281ca3a..3f431b73df92 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -104 +104 @@ static int __meminit vmemmap_populated(unsigned long start, int page_size)
- * vmemmap virtual address space management does not have a traditonal page
+ * vmemmap virtual address space management does not have a traditional page
diff --git a/arch/powerpc/platforms/cell/spufs/spu_restore_crt0.S b/arch/powerpc/platforms/cell/spufs/spu_restore_crt0.S
index 6d799f84763a..eb1c0f9fed35 100644
--- a/arch/powerpc/platforms/cell/spufs/spu_restore_crt0.S
+++ b/arch/powerpc/platforms/cell/spufs/spu_restore_crt0.S
@@ -89 +89 @@ restore_reg_insts:       /* must be quad-word aligned. */
-	 * from the application, e.g. illegal instruciton, halt,
+	 * from the application, e.g. illegal instruction, halt,
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 27778b65a965..79fc4f114bd7 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -1146 +1146 @@ static unsigned char cheetah_mtag_syntab[] = {
-/* Return the highest priority error conditon mentioned. */
+/* Return the highest priority error condition mentioned. */
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b9e516099d07..4a7e0eed000c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -979 +979 @@ bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
- *   to find the destinaiton vCPU.
+ *   to find the destination vCPU.
diff --git a/crypto/drbg.c b/crypto/drbg.c
index b6929eb5f565..0ebb6f86dbcd 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -2027 +2027 @@ static inline int __init drbg_healthcheck_sanity(void)
-	/* overflow addtllen with additonal info string */
+	/* overflow addtllen with additional info string */
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 8ba21747b40a..424447232a27 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -4171 +4171 @@ typedef struct _ATOM_SPREAD_SPECTRUM_INFO
-//ucTVBootUpDefaultStd definiton:
+//ucTVBootUpDefaultStd definition:
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
index 1e870f58dd12..2919be48de8d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
@@ -55 +55 @@
-#define ATOM_TONGA_PP_PLATFORM_CAP_SBIOSPOWERSOURCE            0x4            /* This cap indicates whether power source notificaiton is done by SBIOS directly. */
+#define ATOM_TONGA_PP_PLATFORM_CAP_SBIOSPOWERSOURCE            0x4            /* This cap indicates whether power source notification is done by SBIOS directly. */
@@ -58 +58 @@
-#define ATOM_TONGA_PP_PLATFORM_CAP_HARDWAREDC                 0x20            /* This cap indicates whether power source notificaiton is done by GPIO directly. */
+#define ATOM_TONGA_PP_PLATFORM_CAP_HARDWAREDC                 0x20            /* This cap indicates whether power source notification is done by GPIO directly. */
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 50af399d7f6f..72c0240e3487 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -479 +479 @@ static long malidp500_se_calc_mclk(struct malidp_hw_device *hwdev,
-	 * To avoid float calculaiton, using 15 instead of 1.5 and div by
+	 * To avoid float calculation, using 15 instead of 1.5 and div by
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 30399b245f07..a7179221cae2 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -650 +650 @@ static const struct intel_watermark_params i845_wm_info = {
- * formula. The caller may additonally add extra cachelines
+ * formula. The caller may additionally add extra cachelines
@@ -697 +697 @@ static unsigned int intel_wm_method1(unsigned int pixel_rate,
- * formula. The caller may additonally add extra cachelines
+ * formula. The caller may additionally add extra cachelines
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index ec0e9f7224b5..b7ec61038789 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -404 +404 @@ init_table_(struct nvbios_init *init, u16 offset, const char *name)
-#define init_io_flag_condition_table(b) init_table_((b), 0x0a, "io flag conditon table")
+#define init_io_flag_condition_table(b) init_table_((b), 0x0a, "io flag condition table")
diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.h b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
index 52fc9cc812fc..b0c4abf0de7c 100644
--- a/drivers/media/platform/mtk-vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
@@ -147 +147 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
- * @bs_buf: output bitstream buffer infomraiton
+ * @bs_buf: output bitstream buffer information
diff --git a/drivers/media/platform/seco-cec/seco-cec.h b/drivers/media/platform/seco-cec/seco-cec.h
index 843de8c7dfd4..1f9b412d9bb9 100644
--- a/drivers/media/platform/seco-cec/seco-cec.h
+++ b/drivers/media/platform/seco-cec/seco-cec.h
@@ -27 +27 @@
- * SMBus definitons for Braswell
+ * SMBus definitions for Braswell
diff --git a/drivers/message/fusion/lsi/mpi_ioc.h b/drivers/message/fusion/lsi/mpi_ioc.h
index c249f2994fc1..10d10560130a 100644
--- a/drivers/message/fusion/lsi/mpi_ioc.h
+++ b/drivers/message/fusion/lsi/mpi_ioc.h
@@ -105 +105 @@
- *                      asynchronous notificaiton.
+ *                      asynchronous notification.
diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 026c6ca24540..587d93f724e7 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -998 +998 @@ static int genwqe_next_ddcb_ready(struct genwqe_dev *cd)
- * queue. This is needed for statistics as well as conditon if we want
+ * queue. This is needed for statistics as well as condition if we want
diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 359c5bab45ac..fde954b2a60e 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -567 +567 @@ static int pti_char_open(struct inode *inode, struct file *filp)
- * @inode: Not used in this implementaiton.
+ * @inode: Not used in this implementation.
@@ -666 +666 @@ static struct miscdevice pti_char_driver = {
- * @c:   Not used in this implementaiton.
+ * @c:   Not used in this implementation.
diff --git a/drivers/misc/sgi-xp/xpc.h b/drivers/misc/sgi-xp/xpc.h
index b94d5f767703..82907a5bd989 100644
--- a/drivers/misc/sgi-xp/xpc.h
+++ b/drivers/misc/sgi-xp/xpc.h
@@ -710 +710 @@ struct xpc_partition_uv {
-	unsigned long activate_gru_mq_desc_gpa;	/* phys addr of parititon's */
+	unsigned long activate_gru_mq_desc_gpa;	/* phys addr of partition's */
diff --git a/drivers/misc/sgi-xp/xpc_sn2.c b/drivers/misc/sgi-xp/xpc_sn2.c
index 0ae69b9390ce..092a0dafca19 100644
--- a/drivers/misc/sgi-xp/xpc_sn2.c
+++ b/drivers/misc/sgi-xp/xpc_sn2.c
@@ -1438 +1438 @@ xpc_pull_remote_vars_part_sn2(struct xpc_partition *part)
- * Establish first contact with the remote partititon. This involves pulling
+ * Establish first contact with the remote partition. This involves pulling
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 03cc788511d5..491ebb5fecaa 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1464 +1464 @@ static int macronix_quad_enable(struct spi_nor *nor)
- * spansion_quad_enable() - set QE bit in Configuraiton Register.
+ * spansion_quad_enable() - set QE bit in Configuration Register.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 633b117eb13e..7b672ada63a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -178 +178 @@ static int update_xoff_threshold(struct mlx5e_port_buffer *port_buffer,
- *	Update buffer configuration based on pfc configuraiton and
+ *	Update buffer configuration based on pfc configuration and
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
index 8d14770766b4..a107ba627c1c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
@@ -14 +14 @@ struct mlxsw_sp2_kvdl_part_info {
-	/* For each defined partititon we need to know how many
+	/* For each defined partition we need to know how many
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.h b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
index 9a8fd79611f2..368e88565783 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.h
@@ -308 +308 @@ void qed_iov_bulletin_set_udp_ports(struct qed_hwfn *p_hwfn,
- *  reads from configuraiton space, shmem, etc.
+ *  reads from configuration space, shmem, etc.
diff --git a/drivers/net/wireless/ath/hw.c b/drivers/net/wireless/ath/hw.c
index eae9abf540a7..4350a943b4c7 100644
--- a/drivers/net/wireless/ath/hw.c
+++ b/drivers/net/wireless/ath/hw.c
@@ -89 +89 @@
- * An easy eye-inspeciton of this already should tell you that this frame
+ * An easy eye-inspection of this already should tell you that this frame
diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 8abda2760e04..611966234ee1 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -731 +731 @@ enum pe_stats_mask {
-/* Message definitons - All the messages below need to be packed */
+/* Message definitions - All the messages below need to be packed */
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 3044d8b99a24..5be33dead1ad 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -127 +127 @@ struct nvmf_ctrl_options {
- *			for the purpose of conneciton to an NVMe controller
+ *			for the purpose of connection to an NVMe controller
diff --git a/drivers/scsi/aic7xxx/aic79xx.h b/drivers/scsi/aic7xxx/aic79xx.h
index 9a515551641c..1f3770c3a610 100644
--- a/drivers/scsi/aic7xxx/aic79xx.h
+++ b/drivers/scsi/aic7xxx/aic79xx.h
@@ -390 +390 @@ typedef enum {
- * Status information embedded in the shared poriton of
+ * Status information embedded in the shared portion of
diff --git a/drivers/scsi/aic7xxx/aic7xxx.h b/drivers/scsi/aic7xxx/aic7xxx.h
index 88b90f9806c9..e32ce8953504 100644
--- a/drivers/scsi/aic7xxx/aic7xxx.h
+++ b/drivers/scsi/aic7xxx/aic7xxx.h
@@ -381 +381 @@ typedef enum {
- * Status information embedded in the shared poriton of
+ * Status information embedded in the shared portion of
diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index bb88995a12c7..e1243613a734 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -647 +647 @@ static void esp_unmap_sense(struct esp *esp, struct esp_cmd_entry *ent)
-/* When a contingent allegiance conditon is created, we force feed a
+/* When a contingent allegiance condition is created, we force feed a
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index c7f66239ca70..076982b665b3 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -2391 +2391 @@ lpfc_sli4_bsg_diag_mode_end(struct bsg_job *job)
- * applicaiton.
+ * application.
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index f12780f4cfbb..48281e20b8ff 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1948 +1948 @@ lpfc_cmpl_els_rrq(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
- * checked for error conditons. If there is error status reported, PLOGI
+ * checked for error conditions. If there is error status reported, PLOGI
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index aec0f19597a9..d4f92992dd34 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -2418 +2418 @@ static struct fw_driver fwserial_driver = {
-/* XXX: config ROM definitons could be improved with semi-automated offset
+/* XXX: config ROM definitions could be improved with semi-automated offset
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 952f2ab51347..1e5bd33a25f9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -52 +52 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
-	Please insert all the queue initializaiton using _rtw_init_queue below
+	Please insert all the queue initialization using _rtw_init_queue below
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index b5dcb78fb4f4..675410c0a07a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -52 +52 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
-	Please insert all the queue initializaiton using _rtw_init_queue below
+	Please insert all the queue initialization using _rtw_init_queue below
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 7f06a62f8661..1a0e7c1e0509 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3152 +3152 @@ static const struct sense_info sense_info_table[] = {
-		 * status, with the sense key set to ILLEGAL REQUEST,and the additonal
+		 * status, with the sense key set to ILLEGAL REQUEST,and the additional
diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 247de0faaeb7..2f22c157bbcc 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -75 +75 @@ module_param(dma_ep, ushort, 0644);
- * dma_mode: net2272 dma mode setting (see LOCCTL1 definiton):
+ * dma_mode: net2272 dma mode setting (see LOCCTL1 definition):
diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index 6581774bdfa4..0c3e7b114fd0 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -5 +5 @@
- * HID devices which do not use HID report definitons (they use
+ * HID devices which do not use HID report definitions (they use
diff --git a/drivers/usb/serial/io_usbvend.h b/drivers/usb/serial/io_usbvend.h
index c38e87ac5ea9..d9dedb4f0774 100644
--- a/drivers/usb/serial/io_usbvend.h
+++ b/drivers/usb/serial/io_usbvend.h
@@ -500 +500 @@ struct edge_manuf_descriptor {
-#define MANUF_BOARD_REV_GENERATION_2	0x20	// Second generaiton edgeport
+#define MANUF_BOARD_REV_GENERATION_2	0x20	// Second generation edgeport
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 265d3b45efd0..6383d55989dc 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1063 +1063 @@ static int au1200fb_fb_check_var(struct fb_var_screeninfo *var,
-	/* FIX!!!! what are the implicaitons of ignoring this for windows ??? */
+	/* FIX!!!! what are the implications of ignoring this for windows ??? */
diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index b1cf248f3291..bb4c6891bc80 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -396 +396 @@ static void lcd_cfg_ac_bias(int period, int transitions_per_int)
-	/* Set the AC Bias Period and Number of Transisitons per Interrupt */
+	/* Set the AC Bias Period and Number of Transitions per Interrupt */
diff --git a/include/linux/mfd/wm831x/regulator.h b/include/linux/mfd/wm831x/regulator.h
index 233b3017954a..48ead027bfbd 100644
--- a/include/linux/mfd/wm831x/regulator.h
+++ b/include/linux/mfd/wm831x/regulator.h
@@ -3 +3 @@
- * linux/mfd/wm831x/regulator.h -- Regulator definitons for wm831x
+ * linux/mfd/wm831x/regulator.h -- Regulator definitions for wm831x
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 1fb11daa5c53..cfdd613986aa 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -457 +457 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
- *	* __field(pid_t, prev_prid) is equivalent to a standard declariton:
+ *	* __field(pid_t, prev_prid) is equivalent to a standard declaration:
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index 525848e227dc..b397ecc1b913 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -301 +301 @@ struct rvt_driver_provided {
-	 * Inform the driver the particular qp in quesiton has been reset so
+	 * Inform the driver the particular qp in question has been reset so
diff --git a/mm/memory.c b/mm/memory.c
index 2e796372927f..481e993dd76d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3197 +3197 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
-	 * Archs like ppc64 need additonal space to store information
+	 * Archs like ppc64 need additional space to store information
diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 0468ba500bd4..ea8853e750a1 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -120 +120 @@ struct percpu_stats {
-	size_t min_alloc_size;	/* min allocaiton size */
+	size_t min_alloc_size;	/* min allocation size */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 703857aab00f..ed40c32c7cb1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1281 +1281 @@ static int snd_pcm_do_stop(struct snd_pcm_substream *substream, int state)
-	return 0; /* unconditonally stop all substreams */
+	return 0; /* unconditionally stop all substreams */
diff --git a/sound/isa/sb/emu8000_local.h b/sound/isa/sb/emu8000_local.h
index f90526ab1a3e..92b8922d2b4f 100644
--- a/sound/isa/sb/emu8000_local.h
+++ b/sound/isa/sb/emu8000_local.h
@@ -5 +5 @@
- *  Local defininitons for the emu8000 (AWE32/64)
+ *  Local definitions for the emu8000 (AWE32/64)
diff --git a/sound/pci/emu10k1/emu10k1_synth_local.h b/sound/pci/emu10k1/emu10k1_synth_local.h
index 11373695344b..ae389768a370 100644
--- a/sound/pci/emu10k1/emu10k1_synth_local.h
+++ b/sound/pci/emu10k1/emu10k1_synth_local.h
@@ -5 +5 @@
- *  Local defininitons for Emu10k1 wavetable
+ *  Local definitions for Emu10k1 wavetable
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d821107f55f9..a86d54e9261a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2218 +2218 @@ static inline __u16 btf_fwd_kind(struct btf_type *t)
- * definiton is available. So, if we had unresolved FWD and found corresponding
+ * definition is available. So, if we had unresolved FWD and found corresponding
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
index df9201434cb6..e7adf3a68cd1 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
@@ -114 +114 @@
-        "PublicDescription": "Level 2 access to instruciton TLB that caused a page table walk. This event counts on any instruciton access which causes L2I_TLB_REFILL to count",
+        "PublicDescription": "Level 2 access to instruction TLB that caused a page table walk. This event counts on any instruction access which causes L2I_TLB_REFILL to count",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index 811c2a8c1c9e..ee2ba5fdf904 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -1838 +1838 @@
-        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
+        "BriefDescription": "Cycles in which the NTC instruction is held at dispatch for any reason",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/other.json b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
index af0860622445..fdcf569d0fae 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/other.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
@@ -8 +8 @@
-        "BriefDescription": "Early Branch Prediciton Unit clears"
+        "BriefDescription": "Early Branch Prediction Unit clears"
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/other.json b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
index af0860622445..fdcf569d0fae 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/other.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
@@ -8 +8 @@
-        "BriefDescription": "Early Branch Prediciton Unit clears"
+        "BriefDescription": "Early Branch Prediction Unit clears"
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
index 85133d6a5ce0..dc22e21aa4ca 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
@@ -8 +8 @@
-        "BriefDescription": "Early Branch Prediciton Unit clears"
+        "BriefDescription": "Early Branch Prediction Unit clears"
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
index 85133d6a5ce0..dc22e21aa4ca 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
@@ -8 +8 @@
-        "BriefDescription": "Early Branch Prediciton Unit clears"
+        "BriefDescription": "Early Branch Prediction Unit clears"
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/other.json b/tools/perf/pmu-events/arch/x86/westmereex/other.json
index 85133d6a5ce0..dc22e21aa4ca 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/other.json
@@ -8 +8 @@
-        "BriefDescription": "Early Branch Prediciton Unit clears"
+        "BriefDescription": "Early Branch Prediction Unit clears"
diff --git a/tools/testing/selftests/bpf/test_sock_fields.c b/tools/testing/selftests/bpf/test_sock_fields.c
index f0fc103261a4..9cdbf239ddce 100644
--- a/tools/testing/selftests/bpf/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/test_sock_fields.c
@@ -260 +260 @@ static void check_sk_pkt_out_cnt(int accept_fd, int cli_fd)
-	 * passive conneciton did not become fullsock until 3WHS
+	 * passive connection did not become fullsock until 3WHS


