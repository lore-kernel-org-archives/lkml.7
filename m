Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8CAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB6E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127767;
	bh=7rVw9ZJFXF0WuoNp6q4vq4Mvp3lZnTGxCUyzIgj0bKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EK7eMPBj0MNBH0o2mp8dnEgBdCcXeTca+mff0+CWNb3Ag1Hxb1t2N+Vf0JzlxIatl
	 zWcy4NFRRj18hjEea4aO2Xl/JAeSgQ01Y83scikIUoyuAoCqHGPRvpGKL8y4hS0Fiv
	 Fr4i/A/fSPhXjHakaBM1InCyUWIZRIlRYLnkJsUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391945AbfDXRfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391530AbfDXRfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:38 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C30C2054F;
        Wed, 24 Apr 2019 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127337;
        bh=7rVw9ZJFXF0WuoNp6q4vq4Mvp3lZnTGxCUyzIgj0bKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6zpTCGZofBR/QBtvzw/+iHZkiBJ2mqrbAtbbS4hA7sNB+QIlxY4In9fiEuwUT9yj
         qYIVPwMNVlMzydMWe11KihGXrtgwrtOZN6VDoAygaFCAJCEyrVKcIekgtNH5LFKIhs
         Q6tpXq2muLu06PVgaBZsVbdN1ikRvxRWmN4ldntg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Pollak <leonardp@tr-host.de>,
        Stable@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.0 052/115] Staging: iio: meter: fixed typo
Date:   Wed, 24 Apr 2019 19:09:48 +0200
Message-Id: <20190424170928.122070213@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Pollak <leonardp@tr-host.de>

commit 0a8a29be499cbb67df79370aaf5109085509feb8 upstream.

This patch fixes an obvious typo, which will cause erroneously returning the Peak
Voltage instead of the Peak Current.

Signed-off-by: Leonard Pollak <leonardp@tr-host.de>
Cc: <Stable@vger.kernel.org>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/iio/meter/ade7854.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -269,7 +269,7 @@ static IIO_DEV_ATTR_VPEAK(0644,
 static IIO_DEV_ATTR_IPEAK(0644,
 		ade7854_read_32bit,
 		ade7854_write_32bit,
-		ADE7854_VPEAK);
+		ADE7854_IPEAK);
 static IIO_DEV_ATTR_APHCAL(0644,
 		ade7854_read_16bit,
 		ade7854_write_16bit,


