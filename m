Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900EFC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53851227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576733234;
	bh=MVB1B2T5HuwB3I7OzNlyQPpwCKH8XYnJes9y4BOyA7I=;
	h=In-Reply-To:References:Cc:Subject:From:To:Date:List-ID:From;
	b=CfOy7yILDiiRbbfYcMZwrskjpqBnIVrjIABN8RbmaUnarxE1U06nBd58J8N/8Bk44
	 tM5ROiNV0Om0F+9lehggGSwVlvTBFk/5EKVgF2pIHaOVqmTvN+k6LM2ZG5giBQdwmF
	 3Lya3mSVvcuDIsnpp9lfxC8UkuceRsl2CdAVsycI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLSF1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 00:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfLSF1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:27:13 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04995222C2;
        Thu, 19 Dec 2019 05:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576733232;
        bh=MVB1B2T5HuwB3I7OzNlyQPpwCKH8XYnJes9y4BOyA7I=;
        h=In-Reply-To:References:Cc:Subject:From:To:Date:From;
        b=j+vabZFjMOvHH8oBjeJI7x2YnFynh4Bh/ntugnuzJOqNumrb0iDu5n2rbRS+n8VOu
         u7KLKKxpiXzSDrrYuuwmvzno0y8pZlYYR9P5fZu+kSIGrMXahU2MNYXsrX1eqJm0k3
         v4J7Z/a/dwbE+r94y5OQow29iCVz4R7Ihgdi3amU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731182713.8123-3-tdas@codeaurora.org>
References: <20190731182713.8123-1-tdas@codeaurora.org> <20190731182713.8123-3-tdas@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v3 2/2] clk: qcom : dispcc: Add support for display port clocks
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Wed, 18 Dec 2019 21:27:11 -0800
Message-Id: <20191219052712.04995222C2@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-07-31 11:27:13)
> SDM845 dispcc supports RCG and CBCRs for display port, so add support for
> the same.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

