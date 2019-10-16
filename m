Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC2ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F16218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263510;
	bh=oqYv0CdDEb9mnEpfZAfrAIcIQfo9/lGX7aRzmkFPVYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1l39ORkbp7ep+em0y/VIgC8ifJ1ycrIG2DS2UHscVB+48OWxtMWk7xB+RYU+53qSU
	 y1d0GULtaaTa6MxlAmfgL0/n4Y18NpW7kbUTLC5OAVk3FaVVkwHNlV0aKcTd/iSBTq
	 DZTLhinWBVN9b9BjvbVeqdP41Xh02AYuZPnxnXUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406903AbfJPWFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438322AbfJPV6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:55 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD7221928;
        Wed, 16 Oct 2019 21:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263134;
        bh=oqYv0CdDEb9mnEpfZAfrAIcIQfo9/lGX7aRzmkFPVYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=McThITfMvukO7Wv4tEY9NrLDKQQI4DThze1NoFi6lO+yQiqb7sWJ+zUKiJaUpA7K2
         jQYoqc2vsZqZBQxFKDoyB6GoWozCwvsU18lE8TGuryb1zA4XpB6twy89b62/RD0yvy
         fs+bujywQ2IoldrV3nesua2AAtHwY6COqqW2Upkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.3 058/112] iio: light: add missing vcnl4040 of_compatible
Date:   Wed, 16 Oct 2019 14:50:50 -0700
Message-Id: <20191016214859.789977592@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

commit 7fd1c2606508eb384992251e87d50591393a48d0 upstream.

Commit 5a441aade5b3 ("iio: light: vcnl4000 add support for the VCNL4040
proximity and light sensor") added the support for the vcnl4040 but
forgot to add the of_compatible. Fix this by adding it now.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Fixes: 5a441aade5b3 ("iio: light: vcnl4000 add support for the VCNL4040 proximity and light sensor")
Reviewed-by: Angus Ainslie (Purism) angus@akkea.ca
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/light/vcnl4000.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -409,6 +409,10 @@ static const struct of_device_id vcnl_40
 		.data = "VCNL4020",
 	},
 	{
+		.compatible = "vishay,vcnl4040",
+		.data = (void *)VCNL4040,
+	},
+	{
 		.compatible = "vishay,vcnl4200",
 		.data = "VCNL4200",
 	},


