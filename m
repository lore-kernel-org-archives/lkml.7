Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641F8C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244C221734
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578253547;
	bh=a2DYDSKJQ5NN4MoqXJFvtIJW4KgdLPd/k5EjqG4ijyE=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=teZmUX3ZMYKSCUQNLfc495kTCuhhqvnrikSPe1w/qtcP76eBcXTJD3UojRdFHKWF2
	 Ebk0rvSMYhcdr0/uM8r2H1+PB6xk49cFO6e3WG30skoQ2js9iECJyGHd9dwje1Pcy1
	 Y4tZaDotsR4KlC8OEYJ30WWZMMPGNN+49Z4ziFCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAETpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 14:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgAETpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 14:45:46 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA1E4207FD;
        Sun,  5 Jan 2020 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578253545;
        bh=a2DYDSKJQ5NN4MoqXJFvtIJW4KgdLPd/k5EjqG4ijyE=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=fb7pKj1Zw0roOSixtCX/Nwgey01QuXJqB1o2revTKOwo4wmTRzWv/bwAfqHa9ndvG
         snwrlQJGNXzz6OYNsQOPMwhVs/O65Utk9ypuuKe7gNMPRFRyEhKqmP6AFVvQ2uQ5mH
         QD6ulUJpIznTJfwGrCAA6jk56k9DmFQYWYwQD/fg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9d8288380a387418b01396147a98b9d197a3992b.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com> <9d8288380a387418b01396147a98b9d197a3992b.1574922435.git.shubhrajyoti.datta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     devel@driverdev.osuosl.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH v3 09/10] staging: clocking-wizard: Delete the driver from the staging
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 11:45:44 -0800
Message-Id: <20200105194544.EA1E4207FD@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting shubhrajyoti.datta@gmail.com (2019-11-27 22:36:16)
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>=20
> Delete the driver from the staging as it is in drivers/clk.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Can all these patches in this series apply to the staging paths and be
picked up by Greg? Then when the driver is ready to be moved out of
staging I would like to see one patch that removes the driver from
staging and adds it to drivers/clk/ so we can be certain the diff is
minimal.

Feel free to add me and linux-clk to the review of the clocking-wizard
driver patches. I will review the driver patches that way.

