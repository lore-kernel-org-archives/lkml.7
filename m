Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774EBC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8702171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565976915;
	bh=KwRVVOrbytzGnxOURauAndFe+pfthF388DNgyyvGERk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=fZG+5hWZEHhTc561zCm1wdPfBSTckCWSitbaicPE6uq0MmYxWbpQShqctBuNmHAsM
	 vX+2IY8vE/ILn7xlXGL3x8WIjIqBdMXtqWbyTOURcvGEG0EO40eFY8V1QB6uSxBEMQ
	 WOZKm5HBaEdebTLgDWsE4HA28bnkCOG5imzWFgNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfHPRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfHPRfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:35:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0C32086C;
        Fri, 16 Aug 2019 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976913;
        bh=KwRVVOrbytzGnxOURauAndFe+pfthF388DNgyyvGERk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=xpQpUa2BQ0TqloUC1TlYy1EeGHiyVhpeP/kdEpmzeD87XGk3bB/a3CsWlqZ4ZJLX4
         clm9pfY59Kr3mcwsfTD0QxZwyX1v3TB6MSrl2Mg0ZxQUKBOVnNaskq2FD0MEOZUTQ/
         bAuMuZQ9A8Q3PE0oDC82fmx52XsZDpXJKeXJFAyA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816135944.54232-1-yuehaibing@huawei.com>
References: <20190816135944.54232-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: qcom: clk-rpm: remove unused code
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, agross@kernel.org,
        mturquette@baylibre.com
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:35:12 -0700
Message-Id: <20190816173513.7D0C32086C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-08-16 06:59:44)
> drivers/clk/qcom/clk-rpm.c:453:29: warning:
>  clk_rpm_branch_ops defined but not used [-Wunused-const-variable=3D]
>=20
> It is never used, also the macros 'DEFINE_CLK_RPM_CXO_BRANCH'
> and 'DEFINE_CLK_RPM_CXO_BRANCH' are unused, so remove them.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Sorry, apparently we're leaving this code around for qcom folks to use
one day.

