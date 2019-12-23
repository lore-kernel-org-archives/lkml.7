Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E4C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5035620828
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nBiqSjNT";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nBiqSjNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLWPrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:47:55 -0500
Received: from node.akkea.ca ([192.155.83.177]:38974 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfLWPry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:47:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 4A72A4E200E;
        Mon, 23 Dec 2019 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1577116074; bh=32jFHoBT/8A9zaicn0KxEkscstF6mPjMAkS1keiBsqQ=;
        h=From:To:Cc:Subject:Date;
        b=nBiqSjNTbIcp5dsnZbr3uHOZoeYGPAKrJ/iC6ih9CV1HDcd29I7IzBPAL0i9E4nvr
         NhJRl0w53uRqBhmtKZ4YmBTwI5g5UgYrcIq0DV6lAIE7vV+OThTxcrqvm6vBIF7Ryf
         3MX9io12qtwjzyo+oJJBbeKom0SCNj5bC6HZVuZU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CGd51sVCK05Q; Mon, 23 Dec 2019 15:47:54 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 9C6004E2003;
        Mon, 23 Dec 2019 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1577116074; bh=32jFHoBT/8A9zaicn0KxEkscstF6mPjMAkS1keiBsqQ=;
        h=From:To:Cc:Subject:Date;
        b=nBiqSjNTbIcp5dsnZbr3uHOZoeYGPAKrJ/iC6ih9CV1HDcd29I7IzBPAL0i9E4nvr
         NhJRl0w53uRqBhmtKZ4YmBTwI5g5UgYrcIq0DV6lAIE7vV+OThTxcrqvm6vBIF7Ryf
         3MX9io12qtwjzyo+oJJBbeKom0SCNj5bC6HZVuZU=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     broonie@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm, robh@kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v4 0/2] Add the broadmobi BM818
Date:   Mon, 23 Dec 2019 07:47:10 -0800
Message-Id: <20191223154712.18581-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The broadmobi uses slightly different parameters from the option modems
so add the paramters and document them.

Changes since v3:

Dropped unrelated indentation fix.
Fixed const warning.

Changes since v2:

Use of_device_get_match_data to get the dai data.
Updated subject styles.

Changes since v1:

Cut back the CC list.
Use data from compatible match instead of explicit compatible match.

Angus Ainslie (Purism) (2):
  ASoC: gtm601: add Broadmobi bm818 sound profile
  dt-bindings: sound: gtm601: add the broadmobi interface

 .../devicetree/bindings/sound/gtm601.txt      | 10 +++++--
 sound/soc/codecs/gtm601.c                     | 30 +++++++++++++++++--
 2 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.17.1

