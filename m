Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E692DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC7D20851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="mEmcSbcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfCIKEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 05:04:06 -0500
Received: from fd.dlink.ru ([178.170.168.18]:52150 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfCIKEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 05:04:05 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2019 05:04:05 EST
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 5461C1B2181D; Sat,  9 Mar 2019 12:54:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 5461C1B2181D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1552125255; bh=HR4Uli1TWWbMAdwNjlpmtiOV3gFxvx8wowtjKwhNkuQ=;
        h=From:To:Cc:Subject:Date;
        b=mEmcSbcXd/qbYFkgxLo9SfBWVVR+cL6B2/oqnc0Dvq0Xi2q/Cq7b3MkEkW4DJdHIA
         emmgF8zwEf2Hf+Jkz1j9EklM3CWDraiismlHeRrYbwvE8fo8OHz8pALa6vj480CON+
         lw4TRZHmqB5eXGNN1WUgCjHONch+ZZIbH+h56V0w=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 15B4A1B2181D;
        Sat,  9 Mar 2019 12:54:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 15B4A1B2181D
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id E9DE81B202CF;
        Sat,  9 Mar 2019 12:54:11 +0300 (MSK)
Received: from localhost (unknown [176.112.142.79])
        by mail.rzn.dlink.ru (Postfix) with ESMTPSA;
        Sat,  9 Mar 2019 12:54:11 +0300 (MSK)
From:   Maxim Zhukov <mussitantesmortem@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH 0/2] staging, mt7621: fix build
Date:   Sat,  9 Mar 2019 12:53:58 +0300
Message-Id: <20190309095400.26930-1-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build fixes for mt7621

Maxim Zhukov (2):
  staging, mt7621-eth: fix api for linkmode bitmap
  staging, mt7621-pci: fix build without pci support

 drivers/staging/mt7621-eth/mdio.c  | 12 +++++++++---
 drivers/staging/mt7621-pci/Kconfig |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.21.0

