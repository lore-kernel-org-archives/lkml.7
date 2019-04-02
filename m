Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2B4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792D22075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfDBPFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:05:07 -0400
Received: from ns.iliad.fr ([212.27.33.1]:57970 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfDBPFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:05:07 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3F2FC216BF;
        Tue,  2 Apr 2019 17:05:05 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 292F920C9F;
        Tue,  2 Apr 2019 17:05:05 +0200 (CEST)
To:     Martin Petersen <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: correcting incorrect peripheral device type 0x0
Message-ID: <ab8d589f-db76-9a95-1b55-3e906ad89487@free.fr>
Date:   Tue, 2 Apr 2019 17:05:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Apr  2 17:05:05 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In my boot log, when UFS is enabled, I get the following warnings:

scsi 0:0:0:49488: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c150hN
scsi 0:0:0:49488: Well-known LUN    SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
scsi 0:0:0:49476: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c144hN
scsi 0:0:0:49476: Well-known LUN    SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6
scsi 0:0:0:49456: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c130hN
scsi 0:0:0:49456: Well-known LUN    SAMSUNG  KLUCG4J1EB-B0B1  0200 PQ: 0 ANSI: 6

Is there something I can/should do to fix these issues?
Or may they be safely ignored?

Regards.
