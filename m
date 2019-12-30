Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB52DC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2483206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577735905;
	bh=9xDuSBESpbvwu9OEZAgkD/gG1CUHaUv4oafJzelhBvM=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=PcIlFsXuVSbtUT6C8u7N1M+9s0feMFAqclKNFZfMXjRgwyRffOVcsyucR9JgHTyti
	 iDugHp7+HmudfxLYr0+IjKp331vAZldaU+EvKqxg+/B36RBKzur14PXF9Dgywib8he
	 0IEtyFJNnGhmTW0xe2Fy5fY4B+QvXW+sXAwNqcTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfL3T6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbfL3T6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:58:24 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48E1206CB;
        Mon, 30 Dec 2019 19:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577735903;
        bh=9xDuSBESpbvwu9OEZAgkD/gG1CUHaUv4oafJzelhBvM=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=FTjZCD0J4AgjXnvdBqR+aGV+oNAidCmCDyqsrko3hV/Hah2YmKWQ3cD2V2f7jeZ0Q
         RuPQDVk4WmTEf/pCd5VyUeBM+3cDphGDdOknSDAjSI/FxtYexx7uh4i5qXSMlgr8Rb
         smtZthbvgxlcN/wDpE+JDne+ZVndft1Z48Xa6/ko=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191211140558.10407-2-bparrot@ti.com>
References: <20191211140558.10407-1-bparrot@ti.com> <20191211140558.10407-2-bparrot@ti.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
To:     Benoit Parrot <bparrot@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [Patch v4 01/10] clk: ti: dra7: add cam clkctrl data
User-Agent: alot/0.8.1
Date:   Mon, 30 Dec 2019 11:58:23 -0800
Message-Id: <20191230195823.D48E1206CB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Benoit Parrot (2019-12-11 06:05:49)
> Add clkctrl data for CAM domain.
>=20
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

