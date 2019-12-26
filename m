Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E07CC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D719320828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577397900;
	bh=dDH3D1EfprMu1UoAl8ug4u3jFlQc6Q+o2AOtTd4nevQ=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=bYOaaSYF1PhCJ8Rb3Y1D83kwheAx2Kn3jx+MHjClt0GejZ7RqjZVJWcQMT87GzNgw
	 ocpobBZhQbcCqeHPWuiXenCxVDvFZmi6eUSEba5VYjLxhf17518gUbZpzNNvsOFPH2
	 rpyC3c26rZg+nAHJ/UaBPYCOK/FgEpWuGu5nq8SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfLZWE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfLZWE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:04:59 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4322080D;
        Thu, 26 Dec 2019 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577397898;
        bh=dDH3D1EfprMu1UoAl8ug4u3jFlQc6Q+o2AOtTd4nevQ=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=IztsENYbDRRaxNR33TTwwS8DDrwWNLtlqCT1FrMMS4D0tXoWPf4f2NrtlQOtuZ1aA
         ePg7Bu3e4IM54p9+3+7MQQy+/60e7D2/uh6ulZzcKaOK4/cRhPjutJEa9+5lDVR0K+
         XD8jLeL+6ioGK0/42zO2mF+OxXRfszLeFNzh3C7g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191218111742.29731-9-sudeep.holla@arm.com>
References: <20191218111742.29731-1-sudeep.holla@arm.com> <20191218111742.29731-9-sudeep.holla@arm.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] clk: scmi: Match scmi device by both name and protocol id
User-Agent: alot/0.8.1
Date:   Thu, 26 Dec 2019 14:04:57 -0800
Message-Id: <20191226220458.9E4322080D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2019-12-18 03:17:39)
> The scmi bus now has support to match the driver with devices not only
> based on their protocol id but also based on their device name if one is
> available. This was added to cater the need to support multiple devices
> and drivers for the same protocol.
>=20
> Let us add the name "clocks" to scmi_device_id table in the driver so
> that in matches only with device with the same name and protocol id
> SCMI_PROTOCOL_CLOCK.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

