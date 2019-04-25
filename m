Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96FC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E48206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556205622;
	bh=Ilx9YEoHLRFcqItv3QzrwRRiZw35JzSgAcaZUJ2kzwI=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=op+2Eewkfn8IVHbvQLcLGOwhZHbh0Rvm0g0z50h5tNQFzVFmIbRKLOgwmTUtwqzXP
	 CywuffRxkirMF9dL07DycBW7lorTfs9zKzeFpmg6rrYm9jMwJSWbZVwfQ3jwUOfpz9
	 cfJu0XO5FzYbMBDhqVWbPsNjPmvrwXN1ZNlD7yFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfDYPUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfDYPUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:20:21 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD3E2067D;
        Thu, 25 Apr 2019 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556205620;
        bh=Ilx9YEoHLRFcqItv3QzrwRRiZw35JzSgAcaZUJ2kzwI=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=NJ8wnAANoPqcMdhVcXSMYaolK2QwPJ2hjYIuo+BcoDSOni5C7vI6+3NqL97KR7lNG
         E6lhdf2n3jSIII89O++FcrHB644pwA/zjmhOgSabjHgBLmqaA0gGuK3qgjbDGu+oGl
         726O73QLZRm1fHuK9Ofx3kneyYME0F1EtyKWDpFw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190425132837.18389-1-digetx@gmail.com>
References: <20190425132837.18389-1-digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1] clk: Add missing stubs for a few functions
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>
Message-ID: <155620561976.15276.14971811022769375171@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 08:20:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-25 06:28:37)
> Compilation fails if any of undeclared clk_set_*() functions are in use
> and CONFIG_HAVE_CLK=3Dn.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied to clk-fixes

