Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289AAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E926F20644
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370866;
	bh=lPFa3FZ2IJL5Jre6SYhyJDYntvwt2w0C2DFyXpPrB7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFX1w+K584jXK0sgC/5Eo5la0EpT5jlatsxrVVZT5EjME4+RawbK5zPqckuXWT5/D
	 SThTdpR8TeMhLVT+bGh5sed+dFJpKkd/2YVCl88RG9cCzsDNQUCHV7VDOAGaldcCmf
	 NN3BzSr0+xn2+zaBGdfh4bNGB1jEe4tIeQPTsbKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfFXKHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729947AbfFXKHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:07:32 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B59C208E3;
        Mon, 24 Jun 2019 10:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370851;
        bh=lPFa3FZ2IJL5Jre6SYhyJDYntvwt2w0C2DFyXpPrB7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IH+m/lFdNBBkW8tAom72+rFHUwIDYAywqUBucZfExYZL3ILev8ujBIEORvLkcQYo9
         U8F9IHBPhzl58TN7qhbOJGKnqaakmK1VgIyslb0ewyR6c40h5O5qB/Y3ZVnVVwIbkf
         ilkHN3MPn8XphHAi2rsrImkwhg1Uu2OkxcpM1o7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Smith <danct12@disroot.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.1 024/121] Input: silead - add MSSL0017 to acpi_device_id
Date:   Mon, 24 Jun 2019 17:55:56 +0800
Message-Id: <20190624092321.922852625@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Smith <danct12@disroot.org>

commit 0e658060e5fc50dc282885dc424a94b5d95547e5 upstream.

On Chuwi Hi10 Plus, the Silead device id is MSSL0017.

Signed-off-by: Daniel Smith <danct12@disroot.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/silead.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -617,6 +617,7 @@ static const struct acpi_device_id silea
 	{ "MSSL1680", 0 },
 	{ "MSSL0001", 0 },
 	{ "MSSL0002", 0 },
+	{ "MSSL0017", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);


