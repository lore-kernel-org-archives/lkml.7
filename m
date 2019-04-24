Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DDAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF99121903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127038;
	bh=7rVw9ZJFXF0WuoNp6q4vq4Mvp3lZnTGxCUyzIgj0bKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zg13W+3TnO0fkQWzel0l8kLKJeuVJNLu0fU1Lj5veOITn+GnMxmn0ivknvfiOdV9V
	 DNOWjS7Ax5DQTKAHDTorFdDKCCpjV9SxZs0ioYQYLLfxBzp8XQOTb7IX2myQDheRL1
	 Fd7fS3kbbPHX/lK0cRUQo9JGzrWjT7FasjH/9sX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbfDXRah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391002AbfDXRab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:31 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8616E2054F;
        Wed, 24 Apr 2019 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127031;
        bh=7rVw9ZJFXF0WuoNp6q4vq4Mvp3lZnTGxCUyzIgj0bKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ks70JSghs4juBXi27uIQg10rJEKdgiOIhvOJ7jq9Z1MTgoxrQscqyJS8Ti9k7L14W
         WkGH+vTWQP0cFH1MJvfvI7Abiw/1e9oE69FEqC/3LjN2tbzbqvxivPBr83PV0LByUN
         H+Iki8+meQNG0Ij/yR0GWNozmvv0+hTG2INtvtLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Pollak <leonardp@tr-host.de>,
        Stable@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 34/96] Staging: iio: meter: fixed typo
Date:   Wed, 24 Apr 2019 19:09:39 +0200
Message-Id: <20190424170922.203686257@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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


