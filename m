Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28209C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EE721841
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569609126;
	bh=l2MgxAfQqTBvJzgFFAMW7kFZV7ci+yqItew1m0ywt0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wtMxQG0F6SH4AHWbepFH0v4EHt6GnMjW30L7g501B3LlSA5K2fr1hbQgftVV7ZCDL
	 BeArUVUHAzugZHbAlaSx9jwFheWjy4x+XFqAw8JSwFqu7Zz28wR9W7zSsNKywcLX7u
	 iwkCOUjPe8RUEwAidB2+EGEAI/P6O/6x7uJXThrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfI0ScF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfI0ScF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:32:05 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C7CF217D7;
        Fri, 27 Sep 2019 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569609124;
        bh=l2MgxAfQqTBvJzgFFAMW7kFZV7ci+yqItew1m0ywt0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmDPZ5jm7V7bcMW+f64E9QxeFWXFhK6EkmtlyzDzLrNr2u64hRCH1mt1pFpvn3AOT
         QOI/V46gq93gcwmCvvqdO/HWSAA2pjwtK0G5vh33lAB/MeUfelTUxZEYu5KP5RFSA+
         V61UEHJZyxQIGOHfFXEKqtX12Ye/zrVWBtcItpAI=
Date:   Fri, 27 Sep 2019 20:32:01 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 0/2] drm: LogiCVC display controller support
Message-ID: <20190927183201.hfkhayehmloi34vo@gilmour>
References: <20190927100738.1863563-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tukillri5nr7fxtt"
Content-Disposition: inline
In-Reply-To: <20190927100738.1863563-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tukillri5nr7fxtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2019 at 12:07:36PM +0200, Paul Kocialkowski wrote:
> This series introduces support for the LogiCVC display controller.
> The controller is a bit unusual since it is usually loaded as
> programmable logic on Xilinx FPGAs or Zynq-7000 SoCs.
> More details are presented on the main commit for the driver.
>
> More information about the controller is available on the dedicated
> web page: https://www.logicbricks.com/Products/logiCVC-ML.aspx

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--tukillri5nr7fxtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXY5VoQAKCRDj7w1vZxhR
xYKdAQD7nEpueam4PSkHSKh8hVDVyPCVaXN/FdzJgTHzv4XOkQEAzBZjTbENrCBg
0RfwWhlSmQVPQssAzVRlemjHylV2zQg=
=95Js
-----END PGP SIGNATURE-----

--tukillri5nr7fxtt--
