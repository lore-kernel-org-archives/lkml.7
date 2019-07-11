Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262FC74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED9B21537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfGKHDq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:03:46 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34425 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfGKHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:03:45 -0400
Received: from [192.168.23.168] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id B19AECF2B8;
        Thu, 11 Jul 2019 09:12:16 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] Fixed a brace styling issue
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190710100126.1519-1-2396sheetal@gmail.com>
Date:   Thu, 11 Jul 2019 09:03:42 +0200
Cc:     marcel@holtman.org,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <38EEDC9B-0C4F-4207-BD71-C03E5FC7DE51@holtmann.org>
References: <20190710100126.1519-1-2396sheetal@gmail.com>
To:     sheetalsingala <2396sheetal@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Fixed a coding style issue
> 
> Signed-off-by: Sheetal Singala <2396sheetal@gmail.com>
> ---
> drivers/bluetooth/btintel.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index bb99c8653aab..4a8b812605f3 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -18,7 +18,7 @@
> 
> #define VERSION "0.1"
> 
> -#define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
> +#define BDADDR_INTEL (&(bdaddr_t) {0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00})

maybe you want to test your patches before sending them.

  CC      drivers/bluetooth/btintel.o
drivers/bluetooth/btintel.c: In function ‘btintel_check_bdaddr’:
drivers/bluetooth/btintel.c:21:24: warning: missing braces around initializer [-Wmissing-braces]
   21 | #define BDADDR_INTEL (&(bdaddr_t) {0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00})
      |                        ^
drivers/bluetooth/btintel.c:50:27: note: in expansion of macro ‘BDADDR_INTEL’
   50 |  if (!bacmp(&bda->bdaddr, BDADDR_INTEL)) {
      |                           ^~~~~~~~~~~~

Regards

Marcel

