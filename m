Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892F9C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA292053B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217491;
	bh=2ki/OQssJh7dsatGGsr8QNgg507rtm18gf7W8x+wv3c=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=ELpWucqVLoMXduRsOLaUoeXZqjISTfjYmhOSq3tkYL1y6b13XDkhX6FmrRlgjGG08
	 y19WP0YZIpa/AmTRoB0g3an3c2ULmHaztpCLE2pz552TVOPv3ByC0FiI92Z+sz5Z/c
	 eJk8efVwfxaNsWzBFqAc0Ppn7u4RwhK1xgfp9lEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfDYSiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfDYSiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:38:07 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93D32053B;
        Thu, 25 Apr 2019 18:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556217487;
        bh=2ki/OQssJh7dsatGGsr8QNgg507rtm18gf7W8x+wv3c=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=DwyWE9rPwB1CF7jopBHuPBGCP0PEKwVrv2kk7GVWQmfWRE+on4xVz0qTLMJv+DCbf
         8StPsuAf9cOEek0mEDzPCjb1aT3AMuaFfvqUsSQHkDHyrAhOtfXIlUgSOUk8seEROh
         PztXTqxZ6hJrJaYHWgFmJ77S4uMglsm2F52FrT+g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190424022847.25510-1-andy.tang@nxp.com>
References: <20190424022847.25510-1-andy.tang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: qoriq-clock: Add ls1028a chip compatible string
To:     andy.tang@nxp.com, mturquette@baylibre.com
Message-ID: <155621748632.15276.290181429944098137@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 11:38:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting andy.tang@nxp.com (2019-04-23 19:28:47)
> From: Yuantian Tang <andy.tang@nxp.com>
>=20
> Add ls1028a chip compatible string in binding document.
>=20
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---

Applied to clk-next

