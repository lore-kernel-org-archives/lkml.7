Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B9EC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE88A20857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCCNay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:30:54 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53674 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfCCNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:30:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 84FDC9E73A7;
        Sun,  3 Mar 2019 13:30:52 +0000 (GMT)
Date:   Sun, 3 Mar 2019 13:30:50 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: sps30: fix attribute kernel version
Message-ID: <20190303133050.781e1f0a@archlinux>
In-Reply-To: <20190225181740.13033-1-tduszyns@gmail.com>
References: <20190225181740.13033-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 19:17:40 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> 4.22 have never existed and this change was actually added to 5.0
> hence fix the numbering.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied. Thanks.

Jonathan

> ---
> v2:
>  * this is targeting 5.0 hence fix the version
> 
>  Documentation/ABI/testing/sysfs-bus-iio-sps30 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> index 143df8e89d08..bef52f3e47bc 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-sps30
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
> @@ -1,6 +1,6 @@
>  What:		/sys/bus/iio/devices/iio:deviceX/start_cleaning
>  Date:		December 2018
> -KernelVersion:	4.22
> +KernelVersion:	5.0
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Writing 1 starts sensor self cleaning. Internal fan accelerates
> --
> 2.20.1
> 

