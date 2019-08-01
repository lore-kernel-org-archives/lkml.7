Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B45CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426142064A
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389141AbfHAV0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:26:08 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:39586 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727580AbfHAV0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:26:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id AB61240FC;
        Thu,  1 Aug 2019 21:26:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: moon21_6f484501ab02a
X-Filterd-Recvd-Size: 13428
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 21:26:04 +0000 (UTC)
Message-ID: <d6171bd4ffb3a71c6cd1fb13d74c99776bb7dd64.camel@perches.com>
Subject: [trivial PATCH] treewide: spelling funciton -> function
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 14:26:03 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the function misspellings.

Signed-off-by: Joe Perches <joe@perches.com>
---

sound/soc/codecs/nau8825.c has a couple other typos on the same line.

 drivers/bluetooth/btmtksdio.c                       | 2 +-
 drivers/bluetooth/btmtkuart.c                       | 2 +-
 drivers/bluetooth/btusb.c                           | 2 +-
 drivers/extcon/extcon.c                             | 2 +-
 drivers/mmc/host/sdhci-pci-o2micro.c                | 2 +-
 drivers/net/ethernet/qlogic/qed/qed_int.h           | 2 +-
 drivers/scsi/3w-9xxx.c                              | 2 +-
 drivers/scsi/3w-sas.c                               | 2 +-
 drivers/scsi/3w-xxxx.c                              | 2 +-
 drivers/scsi/lpfc/lpfc_els.c                        | 2 +-
 drivers/scsi/snic/snic_fwint.h                      | 4 ++--
 drivers/scsi/snic/snic_scsi.c                       | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 include/net/caif/caif_layer.h                       | 2 +-
 kernel/bpf/btf.c                                    | 2 +-
 net/core/dev_addr_lists.c                           | 2 +-
 sound/pci/hda/patch_ca0132.c                        | 2 +-
 sound/soc/codecs/nau8825.c                          | 4 ++--
 18 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 813338288453..d84d8da26bac 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -738,7 +738,7 @@ static int mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	wmt_params.data = NULL;
 	wmt_params.status = NULL;
 
-	/* Activate funciton the firmware providing to */
+	/* Activate function the firmware providing to */
 	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index e11169ad8247..debd6a639adb 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -297,7 +297,7 @@ static int mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	wmt_params.data = NULL;
 	wmt_params.status = NULL;
 
-	/* Activate funciton the firmware providing to */
+	/* Activate function the firmware providing to */
 	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5cf0734eb31b..097dc38e2499 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2804,7 +2804,7 @@ static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	wmt_params.data = NULL;
 	wmt_params.status = NULL;
 
-	/* Activate funciton the firmware providing to */
+	/* Activate function the firmware providing to */
 	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e055893fd5c3..9bfb6eaf27c1 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1073,7 +1073,7 @@ EXPORT_SYMBOL_GPL(extcon_dev_free);
  * do not set the values of "internal data", which are initialized by
  * this function.
  *
- * Note that before calling this funciton, have to allocate the memory
+ * Note that before calling this function, have to allocate the memory
  * of an extcon device by using the extcon_dev_allocate(). And the extcon
  * dev should include the supported_cable information.
  *
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 9dc4548271b4..36455ee3694e 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -592,7 +592,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		pci_write_config_dword(chip->pdev,
 				       O2_SD_PLL_SETTING, scratch_32);
 
-		/* Disable UHS1 funciton */
+		/* Disable UHS1 function */
 		ret = pci_read_config_dword(chip->pdev,
 					    O2_SD_CAP_REG2, &scratch_32);
 		if (ret)
diff --git a/drivers/net/ethernet/qlogic/qed/qed_int.h b/drivers/net/ethernet/qlogic/qed/qed_int.h
index d473b522afc5..fccc577d9e37 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_int.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_int.h
@@ -170,7 +170,7 @@ void qed_int_sp_dpc(unsigned long hwfn_cookie);
 
 /**
  * @brief qed_int_get_num_sbs - get the number of status
- *        blocks configured for this funciton in the igu.
+ *        blocks configured for this function in the igu.
  *
  * @param p_hwfn
  * @param p_sb_cnt_info
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 3337b1e80412..fd0dff92a2df 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1694,7 +1694,7 @@ static int twa_reset_sequence(TW_Device_Extension *tw_dev, int soft_reset)
 	return retval;
 } /* End twa_reset_sequence() */
 
-/* This funciton returns unit geometry in cylinders/heads/sectors */
+/* This function returns unit geometry in cylinders/heads/sectors */
 static int twa_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev, sector_t capacity, int geom[])
 {
 	int heads, sectors, cylinders;
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index dda6fa857709..4b3909bcd3be 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1404,7 +1404,7 @@ static int twl_reset_device_extension(TW_Device_Extension *tw_dev, int ioctl_res
 	return retval;
 } /* End twl_reset_device_extension() */
 
-/* This funciton returns unit geometry in cylinders/heads/sectors */
+/* This function returns unit geometry in cylinders/heads/sectors */
 static int twl_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev, sector_t capacity, int geom[])
 {
 	int heads, sectors;
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 2b1e0d503020..8fed4ec1ee19 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1339,7 +1339,7 @@ static int tw_reset_device_extension(TW_Device_Extension *tw_dev)
 	return 0;
 } /* End tw_reset_device_extension() */
 
-/* This funciton returns unit geometry in cylinders/heads/sectors */
+/* This function returns unit geometry in cylinders/heads/sectors */
 static int tw_scsi_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 		sector_t capacity, int geom[]) 
 {
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index f12780f4cfbb..e73104832330 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -7780,7 +7780,7 @@ lpfc_els_rcv_fan(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 }
 
 /**
- * lpfc_els_timeout - Handler funciton to the els timer
+ * lpfc_els_timeout - Handler function to the els timer
  * @ptr: holder for the timer function associated data.
  *
  * This routine is invoked by the ELS timer after timeout. It posts the ELS
diff --git a/drivers/scsi/snic/snic_fwint.h b/drivers/scsi/snic/snic_fwint.h
index 2a045a57e365..5e6520837720 100644
--- a/drivers/scsi/snic/snic_fwint.h
+++ b/drivers/scsi/snic/snic_fwint.h
@@ -109,7 +109,7 @@ struct snic_io_hdr {
 	u16	resvd;
 };
 
-/* auxillary funciton for encoding the snic_io_hdr */
+/* auxillary function for encoding the snic_io_hdr */
 static inline void
 snic_io_hdr_enc(struct snic_io_hdr *hdr, u8 typ, u8 status, u32 id, u32 hid,
 		u16 sg_cnt, ulong ctx)
@@ -124,7 +124,7 @@ snic_io_hdr_enc(struct snic_io_hdr *hdr, u8 typ, u8 status, u32 id, u32 hid,
 	hdr->flags = 0;
 }
 
-/* auxillary funciton for decoding the snic_io_hdr */
+/* auxillary function for decoding the snic_io_hdr */
 static inline void
 snic_io_hdr_dec(struct snic_io_hdr *hdr, u8 *typ, u8 *stat, u32 *cmnd_id,
 		u32 *hid, ulong *ctx)
diff --git a/drivers/scsi/snic/snic_scsi.c b/drivers/scsi/snic/snic_scsi.c
index b3650c989ed4..174ebb9e5ba7 100644
--- a/drivers/scsi/snic/snic_scsi.c
+++ b/drivers/scsi/snic/snic_scsi.c
@@ -2098,7 +2098,7 @@ snic_send_dr_and_wait(struct snic *snic, struct scsi_cmnd *sc)
 }
 
 /*
- * auxillary funciton to check lun reset op is supported or not
+ * auxillary function to check lun reset op is supported or not
  * Not supported if returns 0
  */
 static int
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index c73a8058cf87..813f40e822a9 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -1020,7 +1020,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
  *                                  *  (1) MPInitialization Phase
  *                                  *  (2) Receiving of Deauthentication from AP
  */
-// TODO: Should this funciton be called when receiving of Disassociation?
+// TODO: Should this function be called when receiving of Disassociation?
 void HTInitializeHTInfo(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo = ieee->pHTInfo;
diff --git a/include/net/caif/caif_layer.h b/include/net/caif/caif_layer.h
index 064094101cb5..c59a457655de 100644
--- a/include/net/caif/caif_layer.h
+++ b/include/net/caif/caif_layer.h
@@ -118,7 +118,7 @@ enum caif_direction {
  * @dn:		Pointer down to the layer below.
  * @node:	List node used when layer participate in a list.
  * @receive:	Packet receive function.
- * @transmit:	Packet transmit funciton.
+ * @transmit:	Packet transmit function.
  * @ctrlcmd:	Used for control signalling upwards in the stack.
  * @modemcmd:	Used for control signaling downwards in the stack.
  * @id:		The identity of this layer
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5fcc7a17eb5a..318ee96e15f8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2526,7 +2526,7 @@ static struct btf_kind_operations func_proto_ops = {
 	 * BTF_KIND_FUNC_PROTO cannot be directly referred by
 	 * a struct's member.
 	 *
-	 * It should be a funciton pointer instead.
+	 * It should be a function pointer instead.
 	 * (i.e. struct's member -> BTF_KIND_PTR -> BTF_KIND_FUNC_PROTO)
 	 *
 	 * Hence, there is no btf_func_check_member().
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 6393ba930097..1c87d20a16fa 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -228,7 +228,7 @@ EXPORT_SYMBOL(__hw_addr_unsync);
  *  @sync: function to call if address should be added
  *  @unsync: function to call if address should be removed
  *
- *  This funciton is intended to be called from the ndo_set_rx_mode
+ *  This function is intended to be called from the ndo_set_rx_mode
  *  function of devices that require explicit address add/remove
  *  notifications.  The unsync function may be NULL in which case
  *  the addresses requiring removal will simply be removed without
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0d51823d7270..ade1dcec56ca 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4286,7 +4286,7 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 }
 
 /*
- * This function behaves similarly to the ca0132_select_out funciton above,
+ * This function behaves similarly to the ca0132_select_out function above,
  * except with a few differences. It adds the ability to select the current
  * output with an enumerated control "output source" if the auto detect
  * mute switch is set to off. If the auto detect mute switch is enabled, it
diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 9f5aee7de686..0936710871b5 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1968,7 +1968,7 @@ static void nau8825_component_remove(struct snd_soc_component *component)
 {
 	struct nau8825 *nau8825 = snd_soc_component_get_drvdata(component);
 
-	/* Cancel and reset cross tak suppresstion detection funciton */
+	/* Cancel and reset cross talk suppression detection function */
 	nau8825_xtalk_cancel(nau8825);
 }
 
@@ -2366,7 +2366,7 @@ static int nau8825_set_bias_level(struct snd_soc_component *component,
 		/* ground HPL/HPR, MICGRND1/2 */
 		regmap_update_bits(nau8825->regmap,
 			NAU8825_REG_HSD_CTRL, 0xf, 0xf);
-		/* Cancel and reset cross talk detection funciton */
+		/* Cancel and reset cross talk detection function */
 		nau8825_xtalk_cancel(nau8825);
 		/* Turn off all interruptions before system shutdown. Keep the
 		 * interruption quiet before resume setup completes.


