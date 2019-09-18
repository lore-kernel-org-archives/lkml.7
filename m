Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1221FC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 04:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF009218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 04:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568782321;
	bh=Tw5LhkDLWevFc5xYGBB6qkhpDIA7ULjoLIZ4YB3krlM=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=NlgkktLOUP0txXPc9KZoBgvdfv7Fv23e6Y/1+6kViVRBWa1IKaAnXeyfgLU3v2Mcz
	 1oJf8y1EeU/b8rpQakAY7ZabnixQpi3rdWNLZD7DMlSJ/TWnjRcSajeDKS2lHb3HjL
	 DgGQqqICVPfthkUOSbszgUsEfH7ah0syFnUbj9DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfIREwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 00:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfIREwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 00:52:00 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE9721848;
        Wed, 18 Sep 2019 04:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568782319;
        bh=Tw5LhkDLWevFc5xYGBB6qkhpDIA7ULjoLIZ4YB3krlM=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=lnXdhvaALJADrHLChYPpCB9YsKXblA8vWD1ocjnweVvZZrrMb4oWpYaEppdYx0oG4
         7ZEISNa2FnTHsbGT7LQQo8DOd4kglRrJzxs5jFcjDv+pgh8h5t1RAkibWAn2XhPqFX
         I5vqsEWo/oPlX6GCQfcc59fFJHO9oeMrj6cDbot8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190918013459.15966-1-dinguyen@kernel.org>
References: <20190918013459.15966-1-dinguyen@kernel.org>
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinh.nguyen@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: documentation: add clock bindings information for Agilex
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 21:51:58 -0700
Message-Id: <20190918045159.CCE9721848@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2019-09-17 18:34:58)
> From: Dinh Nguyen <dinh.nguyen@intel.com>
>=20
> Document the Agilex clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the Agilex
> platform.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

This needs a signed-off-by from your intel address as that's the author.

> ---
>  .../devicetree/bindings/clock/intc_agilex.txt | 20 ++++++
>  include/dt-bindings/clock/agilex-clock.h      | 70 +++++++++++++++++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intc_agilex.t=
xt
>  create mode 100644 include/dt-bindings/clock/agilex-clock.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/intc_agilex.txt b/Do=
cumentation/devicetree/bindings/clock/intc_agilex.txt
> new file mode 100644
> index 000000000000..bfec71420511
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intc_agilex.txt
> @@ -0,0 +1,20 @@
> +Device Tree Clock bindings for Intel's SoCFPGA Agilex platform
> +
> +This binding uses the common clock binding[1].

Can you write this binding in YAML? That way we can verify the simple
usage of it easily.

> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be
> +       "intel,agilex-clkmgr"
> +
> +- reg : shall be the control register offset from CLOCK_MANAGER's base f=
or the clock.

I don't quite understand what this means. What is the CLOCK_MANAGER
base for the clock? Doesn't this describe an offset to a clock
controller which provides more than one clk?

> +
> +- #clock-cells : from common clock binding, shall be set to 1.
> +
> +Example:
> +       clkmgr: clock-controller@ffd10000 {
> +               compatible =3D "intel,agilex-clkmgr";
> +               reg =3D <0xffd10000 0x1000>;
> +               #clock-cells =3D <1>;
> +       };
