Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A2DC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6EC2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556216586;
	bh=UlM4Dk+AXEhHrlSRNA8oMUjYFcpUKlq44FwzloZ0ric=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=vVlnuNuG/7hQU6xBH0+L1/WCpgeULxLbXEKd0I2jtqTj/3Ayzsdio0zhPmIJpWc75
	 KJWaFBCQXqaB1KVV8tpo3ukfUVlZaqj0wGhmb6CySbmuK53RrRzwYOyLlS+s6p2cIo
	 d0hW4bfcCVhWIwEU56Wsk4MLan46HImapN6cuq4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfDYSXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDYSXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:23:03 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D98E20717;
        Thu, 25 Apr 2019 18:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556216583;
        bh=UlM4Dk+AXEhHrlSRNA8oMUjYFcpUKlq44FwzloZ0ric=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=LAR82SwIFFehmxCey6B0Cpy8zUd4mVVv7GBNX8b3yJMm44cIeeonk4ADnLZn85O9u
         gUsdaUD4zIEhbQqb6EbF+R6yKKJwG/ggB201dFk7NlD8dSDpC683NXH0mDBy5PB6nt
         xf3mvGxEQ5nccW8uTAXYsn7BBBVtOvU3YLwG2hGU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190422091509.3181-1-andy.tang@nxp.com>
References: <20190422091509.3181-1-andy.tang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: qoriq-clock: add more PLL divider clocks support
To:     andy.tang@nxp.com, mturquette@baylibre.com
Message-ID: <155621658211.15276.13147157968888205274@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 11:23:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting andy.tang@nxp.com (2019-04-22 02:15:08)
> From: Yuantian Tang <andy.tang@nxp.com>
>=20
> More PLL divider clocks are needed by clock consumer IP. So update
> the PLL divider description to make it more general.
>=20
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---

Applied to clk-next

