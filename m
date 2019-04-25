Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79297C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC6A2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556225711;
	bh=ydJrpSfFZsfUmCB+LCIdkF6jXAsDadGS4Sw5OivPnIk=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=aJzvKdt02+KL5gTiFx+uc8rLqEm9363VVUZiFSALi25qdU7h2w8DyHZZc0Jlo+bJg
	 wGjTsySziLkY+HmgR4XJoflGHiRBm384qvHjJL13rX5Axtu4OhPxkvocIhRKxfI4RR
	 WWF8Ct+IW9xH9+Olbcd1EiP/Ay3O7iw1oF/FqVks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfDYUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387943AbfDYUzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:55:09 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB0E2077C;
        Thu, 25 Apr 2019 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556225708;
        bh=ydJrpSfFZsfUmCB+LCIdkF6jXAsDadGS4Sw5OivPnIk=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=GQACpYWS7YfzTR9WdhjqttOVNCS8vMu3qJEyxX4/sE6KkqaGhH2hi9hNt9hAHN1sA
         5DCHoNp5NI73lTKT7moeLaKC2ttRqpAe7gUJzNTp+2H6ceHc64lxDZPGyXju5ZQFsY
         B9lJ1NGnDNAC7LtaDyPPuOkgSe1OU5lvVdd3mJ+w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190414192321.23294-4-digetx@gmail.com>
References: <20190414192321.23294-1-digetx@gmail.com> <20190414192321.23294-4-digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 3/5] clk: tegra: emc: Fix EMC max-rate clamping
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Message-ID: <155622570725.15276.4121840841903621712@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 13:55:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-14 12:23:19)
> When a clk user requests rate that is higher than the maximum possible,
> the rate shall be clamped to the maximum and not to the current value.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied to clk-next

