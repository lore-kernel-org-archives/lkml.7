Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8408C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE272089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfECDet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 23:34:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbfECDet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 23:34:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D06F8ABC4;
        Fri,  3 May 2019 03:34:47 +0000 (UTC)
Date:   Thu, 2 May 2019 20:34:40 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Kilani <omar.kilani@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190503033440.cow6xm4p4hezgkxv@linux-r8p5>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABeXuvrJrdGFUsv7_cAwtyGpc2LpG21+90=jMR4a+CcUPvysRw@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 May 2019, Deepa Dinamani wrote:

>Reported-by: Omar Kilani <omar.kilani@gmail.com>

Do we actually know if this was the issue Omar was hitting?

Thanks,
Davidlohr
