Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18085C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B5F20869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573161090;
	bh=gqfDfrBnuQo+Z0mKDvJgEmduNsQSfl0fa6i3Yyq/oTM=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=PuJXeJrMt8LPkfbKE3dxI0VqdqjJYi9B61wp9wEqS2Tlm1TjNsZt8TftjpUv1KguF
	 j6r4vpH05bEaq74nXHhp6XhmFCYM6pg7C5mjvhnogxK0ZC7bdNXv5Xlrzi2xq4mfTu
	 tldwbd8NUMRqTHpZFCoHGpobiZHCxwt2dMhlpRmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKGVLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfKGVL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:11:29 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC26820869;
        Thu,  7 Nov 2019 21:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573161088;
        bh=gqfDfrBnuQo+Z0mKDvJgEmduNsQSfl0fa6i3Yyq/oTM=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=e95Pv5qsUcRTsMOAv/RrDINlnv8VDglS0sUGW0z4CPRc3LXVsk9pN7eXyANqba8Rx
         lJf2Pxz/OfHK7+CNZQnUSmePybr8ucuKme9fImLFZt3/9n9LGsf6HJiNzsvKbgyelx
         vrA9giSMo11+pHDl6PIz0mQ7jS0QprigXZQ1OVKA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191014102308.27441-2-tdas@codeaurora.org>
References: <20191014102308.27441-1-tdas@codeaurora.org> <20191014102308.27441-2-tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v4 1/5] clk: qcom: rcg: update the DFS macro for RCG
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 13:11:27 -0800
Message-Id: <20191107211128.AC26820869@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-10-14 03:23:04)
> Update the init data name for each of the dynamic frequency switch
> controlled clock associated with the RCG clock name, so that it can be
> generated as per the hardware plan. Thus update the macro accordingly.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

