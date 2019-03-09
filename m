Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66422C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256BD20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 02:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="Ilyk0mXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfCICQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 21:16:29 -0500
Received: from sonic310-25.consmr.mail.ne1.yahoo.com ([66.163.186.206]:45139
        "EHLO sonic310-25.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbfCICQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 21:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1552097788; bh=d+psNcDho3ZCAnLoMbfDKz4j8mOWd9/eE+NvRT5aktA=; h=Date:From:Subject:To:From:Subject; b=Ilyk0mXMUhBOXCAJ/C7eZ3ItzKZ6sDQtKNRLkWVyB6NK6rrvKzKzn7IqP19eTgugqBV8E61/nOsUSFEi/F0CNQzSqrxT34THhedsQyM93seezt1fK75ZycXEP8cU6tuIGFps6ionieMOTQeCdw2i9y8FYeiX8tIYKLwicHOHjm8+8AHjP0xNqWJZPw4PabOkMijSWHwZGgqJS1rNTC/3UAjodGf6XGsMrKZAqjCOKQG366J5E1KbbsNyn5OEXoXaxgrA6DmyRHHESP0pBf51p4twgNGYkSd9yQzO5xA6oy8jnTWNl5KjU5OqldKQLo/2Iot0EfFbWpxI5qMIHn5Njw==
X-YMail-OSG: cEQ3BDAVM1n2sZsMA02ON_iHB_IFQRj_Wn3DD3igwuYhMF4uB8b74jAzRM_jerW
 f6GPme3EbOAyeeaxR.sIpfMUv1P0.5BEEoque47hppQ__CSIbwCzGBMGzV5kZnNqWa5YB1WpjjtN
 XqOZAzxUqeuf0a7ee5I4YvE3P14x1NRE_JkhJ3FHdBiVjVhlyE.vneQy85ms2dHIgdUXvZogiEXK
 aXjcf0MXsSYZ.6MlhI0wBPmcIAwiZ6w8e4nXAdSyCUgahVmKEFK_LKSzVhlKUsyAXDoWVrDzVZ.k
 CJ9JvmgIJixvMPoDkVhoqHhB1WgajEpUiqGIi._zHbHZgrrz2QhWF6UxtYpKsAvdxEb.fhEi2W.F
 tF8fs1xzyLE4.gAw25HLZ5b.A1IRAkgSSLRngsLzEs9LLSzcYoL4hL3nobv1x779fn1FHKcHLkeU
 GKRP7GJNXymT0qccOnVigWA_cXmXIvG83Y8JZC5HidF9KmegnovUg6IPFhnyKeBRrpC83p_rijfm
 eLywZpHa5Ap5xgwjcGxn4j0nFMzXF7kUszUQTPAb.OQeVwHr81b60Wp29A1J.cqQhuxCic7MaWss
 hRQuUNxB3Vh3._s.oEBcUnpq5m34OGDSju6FaHuwOuEgaOaS1rVTj1pb5_bJjQhiNqIVSJFAdk6v
 0lIfpO3Efm..7rvbVTSlnfmk1ny1.WBQi6YL9t4yQ_ICIWmtY4XCxZBdM5aUSzu7jlX8cNmd84cw
 03NK.JgCnHssDYcBrZulj6RzWQapkC5GUJBKLKwnxjosXyM3kknX_aHCBoFoZjax1OftS6z_sGon
 _EoxGgGh7NNk1lrVyDpKNWQdY93FFqFlSaBYN4cOYbZC.u0RMiSn.E4jEGtd9c9FmwByUs5AYcCa
 .MW8ZHV0TzH9lY.3rhNZCNMe1ixCaWAaHrl9liyzaHuTjpNQXIKdtsbHEh5l8752BFdTGEUMCoXh
 PQwiDX8Us95j0Ts_oNpXKlejffWTksAyDgyy2wrI6EE5_aNyxnTNx4c4cpmLuXy73CLkU.5d3KD9
 yvDk42gIgB74.V2yA
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sat, 9 Mar 2019 02:16:28 +0000
Received: from CPE00fc8de26033-CM00fc8de26030.cpe.net.cable.rogers.com (EHLO localhost) ([99.228.156.240])
          by smtp405.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID abdfffb5bfc943dcc12609af88228335;
          Sat, 09 Mar 2019 02:16:24 +0000 (UTC)
Date:   Fri, 08 Mar 2019 21:16:20 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: r8169 only works in promisc mode
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After suspending, my r8169 (not actually 8169, just that driver) only=20
receives packets when in promiscuous mode. I have tried disabling all=20
offload features except highdma [fixed], and it doesn't fix the issue.

I am using torvalds/linux, compiled about two days ago (not sure which=20
commit). I think this happened after a recent upgrade (some time in the=20
past week). Given the long testing cycle, I don't really want to bisect;=20
I am hoping someone has some idea of where the issue could be.

Please CC me on replies.

Thanks,
Alex.
