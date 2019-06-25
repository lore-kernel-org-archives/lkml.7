Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF2BC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420FF208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561503908;
	bh=90Wrt4MwnV1NZ0PqI7Vpf4wwtHJBCVCnf9ChVMO4C2w=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=VPy4Y/juVrizYDv5ySzStaYwhGOlHb5XEsRUziXS9M11vvoILzOn13uDvdVtOCHAl
	 K+TdK3DKBqn17abgkzLB2gis/nrgKhm5q1dIkn48iHhZiU5JlH/FnELvGotLOjziKK
	 PYWhFk6k3hcb5xgrwHaCG4o4Sp3pqZf7tdeLy1Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFYXFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYXFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:05:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AFA72086D;
        Tue, 25 Jun 2019 23:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561503905;
        bh=90Wrt4MwnV1NZ0PqI7Vpf4wwtHJBCVCnf9ChVMO4C2w=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=2H1NJw5HGHkaTnPbpsffdTTS3WcgQec2QUgWzdn28r/UWxBHBrrOWbV/IlyGLElkO
         exxVWPDz7OHNg7+/oy46UoPrrueAfMVMtSfDPO51BgOUbt53GW06Ded7DEyTdRhy9n
         OpzdxA2quE0W0PQUUlrap7+vXA6GcG8n0Et/1r2Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190612182500.4097-6-nsaenzjulienne@suse.de>
References: <20190612182500.4097-1-nsaenzjulienne@suse.de> <20190612182500.4097-6-nsaenzjulienne@suse.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 5/7] clk: raspberrypi: register platform device for raspberrypi-cpufreq
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 16:05:04 -0700
Message-Id: <20190625230505.9AFA72086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-12 11:24:57)
> As 'clk-raspberrypi' depends on RPi's firmware interface, which might be
> configured as a module, the cpu clock might not be available for the
> cpufreq driver during it's init process. So we register the
> 'raspberrypi-cpufreq' platform device after the probe sequence succeeds.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-next

