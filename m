Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66618C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327DA21734
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564158164;
	bh=iSpgErZyH5WtkuKki6MXL2DpHosNdkywhjGnuECrfC8=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=OcY/Z5e+E/kURSW6wwNhh57ju/TlxXSOvTt6TD72JGBIu2iY1gA6b2Xy1wSTbYnC5
	 H6bR33Ag5veGOk0rKg9qPYx2nWWjVMUG3XtQIas375/lxr0IQzlvpm3MUCC1dna0Ca
	 D0DGSvMno9Lc7rtJZihz/iN7i0YJvZmVYDL8DBiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfGZQWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfGZQWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:22:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7757821734;
        Fri, 26 Jul 2019 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564158161;
        bh=iSpgErZyH5WtkuKki6MXL2DpHosNdkywhjGnuECrfC8=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=CGJ6PK7Y8347Q17zhsTTIGstVfqFOXxOUWl6UDZ0MdMMl/qj33/B6WI0sIVPttzb2
         J2qewxcRn7Z3doDqe3EK9iu59Qe4dhYUWsM3JrKJz2eM+XTP6CeJ8npuTQgEYomQ4a
         PZoR2uXk6HNu1xPa+kH14fvxtSJ1Vt157vPSGxdg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190726135138.9858-11-sudeep.holla@arm.com>
References: <20190726135138.9858-1-sudeep.holla@arm.com> <20190726135138.9858-11-sudeep.holla@arm.com>
Subject: Re: [PATCH v2 10/10] firmware: arm_scmi: Use asynchronous CLOCK_RATE_SET when possible
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 26 Jul 2019 09:22:40 -0700
Message-Id: <20190726162241.7757821734@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2019-07-26 06:51:38)
> CLOCK_PROTOCOL_ATTRIBUTES provides attributes to indicate the maximum
> number of pending asynchronous clock rate changes supported by the
> platform. If it's non-zero, then we should be able to use asynchronous
> clock rate set for any clocks until the maximum limit is reached.
>=20
> Tracking the current count of pending asynchronous clock set rate
> requests, we can decide if the incoming/new request for clock set rate
> can be handled asynchronously or not until the maximum limit is
> reached.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

