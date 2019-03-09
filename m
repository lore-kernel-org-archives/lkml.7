Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA31C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45CD207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="daSkRwPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCIQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 11:53:28 -0500
Received: from sonic301-22.consmr.mail.gq1.yahoo.com ([98.137.64.148]:45719
        "EHLO sonic301-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbfCIQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 11:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1552150406; bh=xhy3yalomi8I5dC34d7A89iergpT6boHfVUWML3NtEc=; h=In-Reply-To:References:Subject:From:To:Date:From:Subject; b=daSkRwPqNsqZaK4x+klOuBf05O1zrNI90cV/rZhozt2AZu/KEwUfw2nNSPgS5C1bDDm28q21m7YNsSsO3hnV1ZErBsHIousJy1ZNVfaPcD1NlVDANDxze3SMVLRAzr/JO7X1a9mS1RMfZaQ9sjdHWwaDXf9jGbXAqMOaj4a+jz/Oa5rWocLq4a3qdbx5XPbNU1P0oXy12ZIgFCbeMF7dDkP9p29o+KXpr4XA5Q0YyDI9tYcDSWv4iDi/Kqbg8NFfuvA63z/BkGFrw6G/IykjUYTSHASWoOutw1fP8XzvzLmFgAtIygnNsuTPV3tzkU34cDm4I3HpxEszQHrxCx1mGw==
X-YMail-OSG: 1qmSNLsVM1mKQrjoUZXW0e4U97VgIQtlbshBYx_tgD90zQfsRMstIHk0CY2s7fi
 JUismcr7gfaqSSEoNyzG80JhJQvUXvXicwdaQFB5qmX.XSyyXXXNbJiQUt3BA.0AjjiT_EeXdjZw
 wW9RbFXQs9sY25PVGfto18TZHo0d6EW1QcT5I0_.GkLrVMM7EU18oiJkt1VWUd7ct.eYdqoltqRf
 pihj0xxPXpuJkfcER6f4ONyGBIRV65LUZ8re9MExEHLNGpsJGs3xT_0sZPsSObyuBbvFf4PmLasQ
 qzie_5n1kvbHDkVvKnIy2vx2jeIgHfVbyP.Kn7jUm0DrGu8Bdt0czR3JHDk1qD4x9UTgNHUjqFm3
 JJuF4tpRep2kJZ7TjYTBEsCSsUhe9aGBqO3Y7H.rM4rStXxI9rMfQK5.mP_cGrnLxENHGG6.LV62
 1hMnGyRnfVfLOp.aWo7dPYpZAfUQpbXXtNZsaDZXXz9vB1VbnschWr2w5tLAeNEpm2h2iGEtAmeW
 nLXlSU3YVg3JppEPa7oQ4bfvixsCPg0GogHqisaeVFW9.wIqKCZKC25yMJlBd8EcMTEtEWiKsRGG
 wdw4BSeUpQj6lJLdbHeMmaLhtL6asdPZxuwfJiknMwVwfTdLBaNiHDtEJeUURdDABjMyaBKI3fgi
 pNBDF21ULM8qUsyEnRAQSoIkltt3bKkPbiKdaHOuzAQ6J44ro0IFAOw5uRy_nLRRjkxx5c9FAstx
 L4kLPFN5LXe8_5Zp5bz4CnG6CGfqrFNu1ehDYgBw6XqhfnJRJxm0EA1LjvzHzVzQI2X.diygbJDa
 ie2IgFVihTrs7GKQ0Mws3RG7w_VUrKsDyHvW2yMy3kwZJCVqZtc2pJC1tZPGhyZcyTIZNJsZmJzg
 m25VP_JPKq56nnJ525mMfi5vvvOn3tI6wgEz4.kCsUcjHlooRoWjBv.AtYvonVrRmj99Q0MEc3Qi
 nypzT58ciAqdQ6vt7WDKLrF7GJ9f34DLBsZaSnZwiMXznQs3qflWV996XXvA1AVsUzgRuPbV9mKy
 lPmK9vJ1K4J7_2mj_YKoUaGWnzPcMBr0PnIac
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 9 Mar 2019 16:53:26 +0000
Received: from pink.alxu.ca (EHLO localhost) ([198.98.62.56])
          by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f55f8f68db29febaad90b7206f995093;
          Sat, 09 Mar 2019 16:53:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <82c0ba0d-c7cb-32fb-8e0b-2191b8678c16@gmail.com>
References: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none> <82c0ba0d-c7cb-32fb-8e0b-2191b8678c16@gmail.com>
Subject: Re: r8169 only works in promisc mode
From:   Alex Xu <alex_y_xu@yahoo.ca>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <155215040086.15555.14542326670795337549@pink.alxu.ca>
User-Agent: alot/0.8.1
Date:   Sat, 09 Mar 2019 16:53:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiner Kallweit (2019-03-09 09:33:40)
> On 09.03.2019 03:16, Alex Xu (Hello71) wrote:
> > After suspending, my r8169 (not actually 8169, just that driver) only=20
> > receives packets when in promiscuous mode. I have tried disabling all=20
> > offload features except highdma [fixed], and it doesn't fix the issue.
> >=20
> > I am using torvalds/linux, compiled about two days ago (not sure which =

> > commit). I think this happened after a recent upgrade (some time in the=
=20
> > past week). Given the long testing cycle, I don't really want to bisect=
;=20
> > I am hoping someone has some idea of where the issue could be.
> >=20
> The provided information isn't enough to say anything. Please create a
> bug ticket in bugzilla. Needed information:
> - Last working and first failing kernel version (as reported by uname -a)
> - Is 5.0 ok?
> - Full dmesg log
> - lspci -vv output for the network card
> - If the issue happens only after resume from suspend, diff of the
>   chip registers (ethtool -d) before and after suspend.
> - Does removing / reloading the r8169 module fix the issue?
>=20
> > Please CC me on replies.
> >=20
> > Thanks,
> > Alex.
> >=20
> Heiner

I filed bug 202851 with some of the requested information.

Alex.
