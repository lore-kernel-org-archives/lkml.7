Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461BCC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BF920850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555008461;
	bh=7Mp0OVCPE3P9YpNnwFMuZ6IpmGDkWPVNEziRWO02Uug=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=Am3+1LexA3yb56wKTtZPFHFPaOe70upmI16tT1zJKodduTuncJGqqF8d0Rt0XB2hI
	 rPL1eQiRMFIe88cr8KEbdhYlh6z/cKtXpeDbyt9sOKGOrCAwjN1Qf/Bvd9xV6FA7Pv
	 Akh71iMKZjy6fQREgIHaDy1mEb/tJ2iXNCuCFPi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDKSrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfDKSrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:47:40 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C372083E;
        Thu, 11 Apr 2019 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555008459;
        bh=7Mp0OVCPE3P9YpNnwFMuZ6IpmGDkWPVNEziRWO02Uug=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=LlPiwg1ex6qt2Ito1m3dusg9zaNRfQSGUbUqoB9AbFmzksHvqxtuH7zLU9CdUEmf1
         NY+ZscKQNhpkjbrWgNyOZzsjKzPvozpCk5rttVA6zcTus9YU6k+WTY2y8ofew8IZLT
         SW0TdCtUJIAoAxLBny0Heq130LGC2cnBuZXoLwxM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1554980651-54136-1-git-send-email-hofrat@opentech.at>
References: <1554980651-54136-1-git-send-email-hofrat@opentech.at>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V2] clk: ux500: add range to usleep_range
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@opentech.at>
To:     Nicholas Mc Guire <hofrat@opentech.at>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <155500845872.20095.16468714049509637269@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 11:47:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicholas Mc Guire (2019-04-11 04:04:11)
> Providing a range for usleep_range() allows the hrtimer subsystem to
> coalesce timers - the delay is runtime configurable so a factor 2
> is taken to provide the range. With the expected range for
> enable_delay_us being milliseconds, the range should lie in the 250us
> range which is sufficient for hrtimer optimization.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
> ---

Applied to clk-next

