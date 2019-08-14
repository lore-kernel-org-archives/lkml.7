Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE90CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C4120665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803191;
	bh=nAkuDP2FQ89IlX5/rCnqh9hhxWvJhrfgiaK5H9MwhLs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=MHZPjNkcLqInUwrNC5PhnEROq7lTM+NBVP8iqIIwKWNbWyiwlMgw9n7vzbnsyy5Rj
	 4PNV8012+s4ii5S08HF+VFkw8V4w+IJcOFmhbPr67ZukcZWBUIUnMLG8vRzHT9kKdt
	 QufRywyvrUMqN2CTysvfXwDgFw/GiMm6nJK01Xdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfHNRTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729579AbfHNRTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:19:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E8D20665;
        Wed, 14 Aug 2019 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565803187;
        bh=nAkuDP2FQ89IlX5/rCnqh9hhxWvJhrfgiaK5H9MwhLs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hPQgcdLJ/117BHOcYmgSrhkgHU9qP9D4YV/eUBcWWx2IhPQZoqbKaFvVIdHnZXPBX
         VZ63c3vKXfWdTS1BojNIiOPkGWDBdEXxu4tkGMAOlX/3THqvvn1MD3TATmV/O6u8GK
         pcn5uDs4ZHqJtDYgt6JORouZYBALVlBBXCSy28wM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814122958.4981-2-vkoul@kernel.org>
References: <20190814122958.4981-1-vkoul@kernel.org> <20190814122958.4981-2-vkoul@kernel.org>
Subject: Re: [PATCH 2/2] clk: qcom: clk-rpmh: Add support for SM8150
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Vinod Koul <vkoul@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 10:19:46 -0700
Message-Id: <20190814171946.E9E8D20665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-14 05:29:58)
> Add support for rpmh clocks found in SM8150
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Patch looks OK, but can you convert this driver to use the new parent
style and then update the binding to handle it? We can fix the other
platforms and dts files that use this driver in parallel, but sm8150
will be forward looking.

