Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1146C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FED021530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfFUL7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:59:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfFUL7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:59:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2059CAE9A;
        Fri, 21 Jun 2019 11:59:11 +0000 (UTC)
Date:   Fri, 21 Jun 2019 13:59:09 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Convert remaining drivers to use SPDX identifier
Message-ID: <20190621135909.2057f879@endymion>
In-Reply-To: <1561036786-23190-1-git-send-email-linux@roeck-us.net>
References: <1561036786-23190-1-git-send-email-linux@roeck-us.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 06:19:46 -0700, Guenter Roeck wrote:
> This gets rid of the unnecessary license boilerplate, and avoids
> having to deal with individual patches one by one.
> 
> No functional changes intended.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/adm1029.c    | 10 ----------
>  drivers/hwmon/adt7411.c    |  5 +----
>  drivers/hwmon/adt7475.c    |  5 +----
>  drivers/hwmon/iio_hwmon.c  |  5 +----
>  drivers/hwmon/max197.c     |  5 +----
>  drivers/hwmon/scpi-hwmon.c | 10 +---------
>  6 files changed, 5 insertions(+), 35 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
