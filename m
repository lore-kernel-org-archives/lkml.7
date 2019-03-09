Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C58C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC0320645
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552154615;
	bh=XcGvePLVt+HqFfBYKzMH0krcgClzTZDEInJRulyaVQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DF6nj/bt1gpeNZieUU5d8NrTyS8zzn7eG1hyDGZFE8AXQyQFAOvP5dT0XLOg78WwG
	 hsCWF6LIV4cXz/dFpY+tj4aJ/+HDtJ7XpwMjJFEs6Pt3kYrR13ly44hmdRBkTAQx0I
	 Nh9LV+SpWTJ2MfuVGcBA1wPM/1sG7BFg2R5lbFWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCISDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:03:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCISDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:03:34 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C2ED20645;
        Sat,  9 Mar 2019 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552154613;
        bh=XcGvePLVt+HqFfBYKzMH0krcgClzTZDEInJRulyaVQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IlRxMVSh2YFofNdLhk4wLTIX9F05WaqqaLbjfiS4+iBN4tdi0kz6o2pm7eDVrRhqD
         b6l/7bPc7/59Oyu8rjf1w0ZJOKT6ukM8tDrGR0EAL2tTqgngRgBvlR6RVDOHj2Ew6e
         cFDmykVje/am+ZDLdbFVhRBje5YGzCn3Sh4OJynw=
Date:   Sat, 9 Mar 2019 18:03:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] mailmap: Update email for Sean Nyekjaer
Message-ID: <20190309180322.5beb1497@archlinux>
In-Reply-To: <20190304100808.7391-1-sean@geanix.com>
References: <20190304100808.7391-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 11:08:08 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> As I'll no longer be working with Prevas, add a mailmap entry so
> any mail directed towards me reaches the appropriate mailbox.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Applied.

Thanks,

Jonathan

> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.mailmap b/.mailmap
> index ea98fcc197e4..4087826d8753 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -186,6 +186,7 @@ Santosh Shilimkar <ssantosh@kernel.org>
>  Santosh Shilimkar <santosh.shilimkar@oracle.org>
>  Sascha Hauer <s.hauer@pengutronix.de>
>  S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
> +Sean Nyekjaer <sean@geanix.com> <sean.nyekjaer@prevas.dk>
>  Sebastian Reichel <sre@kernel.org> <sre@debian.org>
>  Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
>  Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>

