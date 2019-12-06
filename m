Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0978FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0F920659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfLFPtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:49:24 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:42037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfLFPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:49:24 -0500
Received: from [192.168.1.155] ([95.117.69.190]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M4ahC-1idoLh05zi-001hxx; Fri, 06 Dec 2019 16:49:11 +0100
Subject: Re: [PATCH 1/2] Enlist running kernel modules information
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, dsterba@suse.cz,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191203094845.610692-1-unixbhaskar@gmail.com>
 <CAK7LNASyrYv+pufwe4CfiNvd7NtriLw=FRdLOtu7CrbmZDSVHg@mail.gmail.com>
 <20191204150728.GD2734@twin.jikos.cz> <20191205032503.GA3981@debian>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <06491eb2-b43c-badc-ce3c-7709abe06a3f@metux.net>
Date:   Fri, 6 Dec 2019 16:48:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191205032503.GA3981@debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: tl
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tInG3W5/9Ev12kB4GwOSl/nLu+cykGvnmavZ5PabZt2BGoff1b7
 8LODrXEqdGO2eqCOazk8nxuB8zzvFYDJchlXWdbYYkSDhcVOwxugdFrIkVWN53eUJAnp7vS
 vQ+ol5F4G+YxnO5jXqoaYKrPG93Xg0Xe4YeVngAbG6bErR8w8Fke9TVVC3Y/SQR2gh53hzL
 W1NBxlQmlPWhZOOOm4DKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UOaswpM5mqA=:gnho6W/s7c5tH1ofPoql7i
 kDSxDTlUEQGF994uQxtc28OlxdOsjyuo45EBlEpjR/4M0McoS/CXhoA4ZcRUF35qLvNW/5Uj+
 V9PAAHuVz4OVMPg3MD7vTNR0x9vJ3+sn9vKVT4mhO1uXeGfo4Cm3Hm0/Dc3ECe8PrxYFoEbXX
 xpHOTe+tbXT2PZayQtq+UDSBPM7ebquImGFGqqh0Y316OAeJqV+N7awRr30b2QP9GR1ivTpdz
 8+u6eC2gjxAnjvU7HjuDaRmviIB9lBGKhnrwsgKffjX7bzTfSlIM/RT8WWuCKkjwsRTh1YDek
 t+8Lb6uvKDq0QFCdyHJKfk6cJKt0He87NtUn9200K0Pof0s88tVGAArJaBPQ/vzeqbkZ45rf5
 qpzc+KLTMUDhOlROoqNiPx5r4czFBmFKOr+WMZHC+kM4FYoq8ewmIydPlZhrLQH3FOvGEX3A5
 6sbI/5wtLrcf4OtK1Cxt50XbRqJFCpc6Uf5Zu7OCAUk6zGvosN8qNBZnUorvdGB5pHGgqHHyX
 my3vutcF3/uBSoYAAWfz0RmuoADYsbVhhykeybjgopPHbHc+wCVKVADdZLnoHF7vh6lLjAgO3
 hUcA/ugR+uXy2ttLimsAQtFqsyUmmlAWzw41iEEmkZ2bhYXRjE0hQfZmhpRX5GPY1COp5h46f
 fwSDu908eXSK0Nu0Yl+WFj+VuV6SGF6h4TGyYK0kj27r8yu9AM3iw9rMkwydIM5q5BQ31qAn6
 PrtiGIMPLeBioVOw54rQKKrIvX59H3ofyDxhTI9T7/F4jJY291RNXRzvJRvjLCYPt+Wpped6w
 GupYpE1EsnT/q0hdZuMAshoLCp7sG4RGyzfaNefrGDKmdjKWlaIFS3Bu9UmECqG3cCFTQePrg
 nB62kclpNfjt8RGoqbVg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.19 04:25, Bhaskar Chowdhury wrote:

Hi,

> The whole point behind this is to give the developers a convenient point
> without going through all the rigorous details.

I see your point, but I wonder whether it maybe better should go
into kmod.

--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
