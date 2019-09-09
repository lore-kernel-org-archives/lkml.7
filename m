Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C3DC49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971DE21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568045134;
	bh=tbUVfRPpbud8L9YMdc4zBmylzHlmc625NS7dVlLtZy4=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=ivF/YB2nJrqKegs9skpuJbdXWQ6+SLCHTnoK90Wi50gBp99crmpkVXz1GLjH3waj3
	 P3Pzl3Gq1dz0SA72FQV9PWRVNzelN6pafaGJdxxclIHRmyVHTkXbYBfdnjD/CTO6ar
	 8f4m0LfN1NF6m+b+NCU0MmWjVFqCzd4pJDwhah6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfIIQFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfIIQFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:05:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940F621924;
        Mon,  9 Sep 2019 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568045131;
        bh=tbUVfRPpbud8L9YMdc4zBmylzHlmc625NS7dVlLtZy4=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=oXwarqvwvM7Cl93PjauUrEF/VupIk2KSS9Har/TXW94LEe6c5QYZszgFHKS3whGEh
         kpSCagCyVjMvRszhiYsoPkuXJTRaiJgL7NEo4DbyXL9mg3/DSiZOwbyvU0ug3FZfMj
         HnrTWekPk6ExJ2ZOSSkoQAdw61bjU/+sWqrvqNtc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190909085430.8700-1-jorge.ramirez-ortiz@linaro.org>
References: <20190909085430.8700-1-jorge.ramirez-ortiz@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jorge.ramirez-ortiz@linaro.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk: qcom: fix QCS404 TuringCC regmap
User-Agent: alot/0.8.1
Date:   Mon, 09 Sep 2019 09:05:30 -0700
Message-Id: <20190909160531.940F621924@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-09-09 01:54:30)
> The max register is 0x23004 as per the manual (the current
> max_register that this commit is fixing is actually out of bounds).
>=20
> Fixes: 892df0191b29 ("clk: qcom: Add QCS404 TuringCC")
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---

Applied to clk-next

