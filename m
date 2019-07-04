Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661CBC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4792189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfGDMCV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:02:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:51504 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfGDMCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:02:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 05:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="187560152"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2019 05:02:20 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jul 2019 05:02:20 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jul 2019 05:02:20 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.240]) with mapi id 14.03.0439.000;
 Thu, 4 Jul 2019 20:02:18 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "kailang@realtek.com" <kailang@realtek.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "chiu@endlessm.com" <chiu@endlessm.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>
Subject: audio lost from speaker after reboot from windows on the device
 ALC295
Thread-Topic: audio lost from speaker after reboot from windows on the
 device ALC295
Thread-Index: AdUyX8fMiuN0r83nQWCeaW0Sd+ObdQ==
Date:   Thu, 4 Jul 2019 12:02:17 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52AB58B6@SHSMSX104.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzE4ZTNhZGMtYjQ0NS00OGRmLWJhYjQtZjA5YTdmZDhiMTc2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidFF2MmlOcjU3NmY3VG9Fb3BuMkJnK25uK3VPYWlCa3RcL08xamVKU2o4aEpqUnBlSVNDTlwvbkVWNHAxTUVxOHdEIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, patch_realtek.c maintainer:
	I see one issue that reboot from windows and boot to ubuntu, the audio lost from speaker, I suspect there are some bugs in patch_realtek.c drivers,  the device is ALC295 and the device id is 0x10ec0295.

I have done the below experiments:
1. reboot from windows to windows, the audio is persist .
2. reboot from windows to ubuntu, the audio lost from speaker, but can hear if I hotplug one earphone.
3. if the issue reproduce after reboot from windows, reboot the ubuntu can't restore the audio, I suspect it's warm reset.
4. if I write the port 0xcf9 with 0xe to do cold reset, the audio can restore.
5. if I do suspend/resume, the audio can restore, I suspect do cold boot and suspend will trigger the platform reset to reset the ALC295.
6. if I do double function reset (write the verb 0x7ff in alc_init), the audio is still can't restore.
snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_CODEC_RESET, 0); /* Function reset */
snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_CODEC_RESET, 0); /* double Function reset */
7. the issue is first found on kernel 4.19.50, I still see the issue with the latest kernel 5.2-rc2, is it possible windows change some default registers, but ALC295 don't initialize the register?
