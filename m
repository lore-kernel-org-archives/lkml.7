Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2735FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0122071C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mYThrQVl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="ZGtl7/F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKRWss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:48:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55085 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfKRWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:48:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E2841D378;
        Mon, 18 Nov 2019 17:48:46 -0500 (EST)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=aOY
        z91GxiTw6gq3rm8N3MnoALFE=; b=mYThrQVlCiRRabVUbnjA2bf71YwlzLJO5aS
        kBVIpdPMOIjRdCFZice/L6mMZ8vdYf69yozzx0h9PltR62oYY9vMQ/DyPc6iYk3z
        XlO2H9z2XeLh7/s+a1/EgBWq9IsSMBv62WrLaCv3n5brUCqoZ11fOvej2LKhwxD3
        HdKk+3Ac=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46D761D377;
        Mon, 18 Nov 2019 17:48:46 -0500 (EST)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=TXrgYPE6DKfCO+LTmxwgcatpSBiHwJ+V747VzWXM2Zw=;
 b=ZGtl7/F3HT4wcJ9gjy5qSOu8Vg8KJGzn37joqE3VKd3U1i+dfMibZVuB2USqnSavreHpXyeZUAoXQ6ibZlz9OHhD2d2ebB5d/R/UWoqNEaBfgFDXBO7/xXvMCrvkFjN+IsHea/0IlKzMLz519ZDtUsqWt+k379GdJIDxQxssu8g=
Received: from Cheese (unknown [24.19.107.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C6821D376;
        Mon, 18 Nov 2019 17:48:45 -0500 (EST)
        (envelope-from tdavies@darkphysics.net)
Date:   Mon, 18 Nov 2019 14:48:37 -0800
From:   Travis Davies <tdavies@darkphysics.net>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] net: Fix comment block per style guide
Message-ID: <20191118224837.GA5138@Cheese>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Pobox-Relay-ID: 93D587D2-0A55-11EA-AC3A-C28CBED8090B-64344220!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch places /* and */ on separate lines for a
multiline block comment, in order to keep code style
consistant with majority of blocks throughout the file.

This will prevent a checkpatch.pl warning:
'Block comments use a trailing */ on a separate line'

---
-v2: Fix commit description, and subject line as suggested by 
     Julia Lawall.

 include/linux/netdevice.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c20f190b4c18..a2605e043fa2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -95,9 +95,11 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 #define NET_XMIT_CN		0x02	/* congestion notification	*/
 #define NET_XMIT_MASK		0x0f	/* qdisc flags in net/sch_generic.h */
 
-/* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
+/*
+ * NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
  * indicates that the device will soon be dropping packets, or already drops
- * some packets of the same priority; prompting us to send less aggressively. */
+ * some packets of the same priority; prompting us to send less aggressively.
+ */
 #define net_xmit_eval(e)	((e) == NET_XMIT_CN ? 0 : (e))
 #define net_xmit_errno(e)	((e) != NET_XMIT_CN ? -ENOBUFS : 0)
 
-- 
2.21.0

