Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD51C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E234C2068F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="sQ2dFGQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKTUWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:22:15 -0500
Received: from forward501o.mail.yandex.net ([37.140.190.203]:45162 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbfKTUWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:22:15 -0500
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 15:22:14 EST
Received: from mxback17g.mail.yandex.net (mxback17g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:317])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 695911E80278;
        Wed, 20 Nov 2019 23:16:30 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback17g.mail.yandex.net (mxback/Yandex) with ESMTP id jcvVD9lzvY-GTvWJpkQ;
        Wed, 20 Nov 2019 23:16:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1574280989;
        bh=9S7fCJni22zH4j8Nnc3/KM8VfE4W3KxpaUC2ZqQtD34=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=sQ2dFGQfTvHOlponnv58auiy2IrlGRkalqqItkex8tARD7zrGfkpzZTEnYr3PTqeE
         TRn576+OwkNjEYkJxNiv/e7iuDpem5Ak1hcKOv6oCswc8UaLqNUa5byhAJ6gdw9cPY
         686MTYmnjQeCoaIcAky4Rj2ZCON9fe0gyNzTQZAE=
Authentication-Results: mxback17g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-7fadb031fd9b.qloud-c.yandex.net with HTTP;
        Wed, 20 Nov 2019 23:16:29 +0300
From:   Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20191019204015.61474-1-angelo.dureghello@timesys.com>
References: <20191019204015.61474-1-angelo.dureghello@timesys.com>
Subject: Re: [PATCH v2] w1: new driver. DS2430 chip
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 20 Nov 2019 23:16:29 +0300
Message-Id: <49814061574280989@sas2-7fadb031fd9b.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo, Greg

19.10.2019, 23:38, "Angelo Dureghello" <angelo.dureghello@timesys.com>:
> add support for ds2430, 1 page, 256bit (32bytes) eeprom
> (family 0x14).
>
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>

Looks good to me.
Greg, please pull it into your tree.

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
