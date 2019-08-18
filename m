Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE79C3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A13D2054F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566158791;
	bh=SYTQFmllUj0sRe6eoRt8kPRi0ybZPLwK7ROPJnytxrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PVsGznqGz+A5yHb3fcSrqwjoZ+E5sN0u5MPer1/fn5b6Dziud3qSsGaqqX0/cwdgy
	 sdarPUZRMDkA0Czp01OMqD2SBnbYUydldmfnOxM8QMYjW3DG3pLbfHl8GViRO2S3BA
	 irD+N938CQhyUhJr1sJu9isRPc71vHEYdXM0vk5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfHRUGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 16:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfHRUG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 16:06:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB1E2184D;
        Sun, 18 Aug 2019 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566157662;
        bh=SYTQFmllUj0sRe6eoRt8kPRi0ybZPLwK7ROPJnytxrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AkEhtMWwz6odUWUzD0q2mHa8tcrGyyp29MpuZcXO1f1n/DIEq/OI+tJuduc5y5U3S
         7rAbH6F1pRZP1m8ocs4W0u0CR3RSssIjIY1M3Vo6nNl5sjYhjA0OqYt+TsgSXy8n+8
         N+P3DK3qSKN8Re7bOcv2kuMqO8Gbz2bgjl7Vy5kw=
Date:   Sun, 18 Aug 2019 20:47:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] tools: iio: add .gitignore
Message-ID: <20190818204737.1f92ee53@archlinux>
In-Reply-To: <20190812124141.9108-1-brgl@bgdev.pl>
References: <20190812124141.9108-1-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 14:41:41 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The generated files must not be tracked by git. Add a local .gitignore.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  tools/iio/.gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 tools/iio/.gitignore
> 
> diff --git a/tools/iio/.gitignore b/tools/iio/.gitignore
> new file mode 100644
> index 000000000000..3758202618bd
> --- /dev/null
> +++ b/tools/iio/.gitignore
> @@ -0,0 +1,4 @@
> +iio_event_monitor
> +iio_generic_buffer
> +lsiio
> +include/

