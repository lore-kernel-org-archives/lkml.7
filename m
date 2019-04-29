Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2401CC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC102075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556561731;
	bh=fx4OITbER8lfWRFsjpKYjxmfmM4FFQhcrIIX7592miI=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=DpP+lnlEc7gFDIRMWbEewL9xfgyvxuEbsDMV0NTR29YW8Wr2okuAzR2QU9mKibP0B
	 nwgke/8eUQLOWysoxv3xeO+59D0lNVeDPft7SBbpVA3MiDORa3ZgGAJvJHTj203v2v
	 PUrcg97x2NWdUTXIOpZctCxlByg2iRSDTrpINQas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfD2SPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbfD2SPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:15:24 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342122075E;
        Mon, 29 Apr 2019 18:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556561724;
        bh=fx4OITbER8lfWRFsjpKYjxmfmM4FFQhcrIIX7592miI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=hBkCppFmJ6UYtguHRR5FERpqeoSf2uQwVsMZ3cArS4hrgDCvnGEo7gmPYlowPOfVb
         quvs3JIhvpsjrbJpAU0yu4UAxQ2Ru3YE66nAaLGgP8bHIudOJNmemEVx5ZF4aSTejH
         mQwBWkqB2SX2rwUhnemVjspcamqOIs9TjpSxXOTM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556531652-27740-1-git-send-email-gerald.baeza@st.com>
References: <1556531652-27740-1-git-send-email-gerald.baeza@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/1] clk: stm32mp1: Add ddrperfm clock
To:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>
Message-ID: <155656172338.168659.837239195206058428@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 29 Apr 2019 11:15:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gerald BAEZA (2019-04-29 02:54:44)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> Add ddrperfm clock for DDR Performance Monitor driver
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> ---

Applied to clk-next

