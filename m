Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09343C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60B92075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573155184;
	bh=t2V/SkooUIaoThHxE9uqbgqy1lEM+6lfOL5vMVPMZJM=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=nhdiK5C79IwlZ2Se+D7juQss8wxLy/miCo29zF0rWi2btJi9PGeFjo+FI4LDQir8l
	 BStFLE0MxKQsTMM39k2pgyplqhtozhYSyUZJJAOhen4jrcrmtpXksqfDbAFOCBYfQN
	 GnJ+4CCJnhcTPQDNZs6Uyya014ZvD5jvrcqa67Tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKGTdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfKGTdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:33:03 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50692087E;
        Thu,  7 Nov 2019 19:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573155183;
        bh=t2V/SkooUIaoThHxE9uqbgqy1lEM+6lfOL5vMVPMZJM=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=LKPsJcDboGx1XgGIUZtS67K6nX26WfDByCzENkH+K1O+fy0EzycCepEk+ri68Gqkf
         fKkFbOMwkJJjQTEbBQ29UsYr0nlZR5rv0wOQxd2hvBTAC0+bzH8dwaPaV1EWGqsSVY
         38Ji59oGFf1lBfYQJeoYVO4t2+MVrAtCbT/j5VsM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191025093332.27592-1-yuehaibing@huawei.com>
References: <20191025093332.27592-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, agross@kernel.org,
        mturquette@baylibre.com
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: qcom: remove unneeded semicolon
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 11:33:02 -0800
Message-Id: <20191107193302.E50692087E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-25 02:33:32)
> remove unneeded semicolon.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

