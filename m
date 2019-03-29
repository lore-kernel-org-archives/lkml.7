Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B4FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57297217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553899749;
	bh=GV+izptyYmo+vlcN/98TyLqJg7ve6KpDouC2W+axdyM=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=wadj4y/Zqc33DyC5Unh26XsCiMNrBLKWRpa3qLx38m80pjJzQQuQ4QmaaS0YDesgN
	 NsbcVk0EEB3PS5wNu7C+AgBI3D+2fBJk0LxwDXldTeMeLuUsjC5MqnGJZ0anAPvDdx
	 UIcKxPQIFjWjA7HnMI7zPO9ayPZSZl9iT9ckY/Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfC2WtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbfC2WtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:49:07 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C4C5217F5;
        Fri, 29 Mar 2019 22:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553899747;
        bh=GV+izptyYmo+vlcN/98TyLqJg7ve6KpDouC2W+axdyM=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=dMYvwXkMfyAM1GROMXbRWYZQbjDTKyJjjdpqpEdabutrJ8ffqDwDkT0FH5AIIJvXs
         4VH4B9Zp9lp77IrvVs9+PbjmJHhMVDOBf5DcQrNA0pTLxirSMtOZfeLh18SvQsVDnx
         Bd0Io7raMqZFkpEOmmBgrnxRMaIIHHD6RMPcSd44=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190329141512.29867-3-jbrunet@baylibre.com>
References: <20190329141512.29867-1-jbrunet@baylibre.com> <20190329141512.29867-3-jbrunet@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: phy: add amlogic g12a mdio mux support
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Message-ID: <155389974643.20095.8059052762611235333@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 29 Mar 2019 15:49:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-03-29 07:15:11)
> Add support for the mdio mux and internal phy glue of the g12a SoC family
>=20
> [for the clock part]
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

I think you should write it like:

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com> # clk parts

