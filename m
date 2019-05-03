Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37DDC04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 02:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EF72087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 02:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfECCeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 22:34:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35772 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfECCep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 22:34:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 24CCA1F453;
        Fri,  3 May 2019 02:34:45 +0000 (UTC)
Date:   Fri, 3 May 2019 02:34:44 +0000
From:   Eric Wong <e@80x24.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Omar Kilani <omar.kilani@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190503023444.m6hvyb7sqtjzub62@dcvr>
References: <20190428004858.el3yk6hljloeoxza@dcvr>
 <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
 <20190429210427.dmfemfft2t2gdwko@dcvr>
 <CABeXuvqpAjk8ocRUabVU4Yviv7kgRkMneLE1Xy-jAtHdXAHBVw@mail.gmail.com>
 <20190501021405.hfvd7ps623liu25i@dcvr>
 <20190501073906.ekqr7xbw3qkfgv56@dcvr>
 <CABeXuvq7gCV2qPOo+Q8jvNyRaTvhkRLRbnL_oJ-AuK7Sp=P3QQ@mail.gmail.com>
 <20190501204826.umekxc7oynslakes@dcvr>
 <CABeXuvqbCDhp+67SpGLAO7dYiWzWufewQBn+MTxY5NYsaQVrPg@mail.gmail.com>
 <CABeXuvrJrdGFUsv7_cAwtyGpc2LpG21+90=jMR4a+CcUPvysRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABeXuvrJrdGFUsv7_cAwtyGpc2LpG21+90=jMR4a+CcUPvysRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> Eric,
> Can you please help test this?

Nope, that was _really_ badly whitespace-damaged.
(C'mon, it's not like you're new to this)
