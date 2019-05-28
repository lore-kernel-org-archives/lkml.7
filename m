Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5970DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345E3206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfE1PgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:36:03 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfE1PgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:36:03 -0400
Received: from excalibur.cnev.de ([194.8.209.98]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mr9O4-1greUz32BS-00oJRo; Tue, 28 May 2019 17:35:43 +0200
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1hVe8c-0001uJ-Ri; Tue, 28 May 2019 17:35:42 +0200
Date:   Tue, 28 May 2019 17:35:42 +0200
From:   Karsten Merker <merker@debian.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Testing the recent RISC-V DT patchsets
Message-ID: <20190528153542.jfkkwycyc3vu6hld@excalibur.cnev.de>
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com>
 <86o93mpqbx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86o93mpqbx.fsf@baylibre.com>
X-No-Archive: yes
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:q1RFbpS43fZk0cIEvnP3mp71E4gqF5+PmQXoFepr6Zzd9xwJRNx
 XZlPVk5Bwiu22vHbMzOpVPGOlsIrjuhRDwTzHdGXKQaOIM+P6XiM+enH/QqmGPecYntTJZU
 z2z9VpYwKAEn1BtqxRd0egnxVe42ZHuc8KoLlERu3/FPIyd452Mw16S7vIUwT6lVKXuXQfs
 Y2WXpbet5ildzafT72g2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MlSVCLPxWJk=:iSdZjF3rN3lUWzuNAX4hpC
 8E41MTvMzjQ7s71CIfK26w6NemSFWsZEsnJRGyurrm9IR8X34vRhgo+s8otFU3uPvmkd7N2Ia
 lcszkOZX8exczPdKO5Po9suy7YghTDfUGW6Lr5FItX1k8UClIRtz0/PUvUpaGzPMAYTh3hzWZ
 8ji5iwfDOYxx529YKvy1oultMOtBaiaqtGXdwHYkD2UPRgUD6xZwuduYxxErGAKVSuz49T2do
 a5z9wSuDHJJV9XDPBaNQolGoGHuyZrYYngQLfgMOKDqlIRfBbBJZ7FnDCu8TWP7uqK/TdgKIQ
 ASEgjt1HRnPpCuZzn6Fskp2dyKCHnHwG5m+GHfUo7L0V9v1vPSvfQ8mc0q82/YNMlHQbg3qgI
 5+Oqir23QukEHvrzwCTzaIyAffRtftp0+tQiYiokYU1T5Dm3LE5vxzN2XyzeNBF3o2++dWBxz
 bkX3jJ/tVrSK6n2tziepoMQQTKrL2eGSIIRr5LAdch82gGxF3w6OTA4h9cCd3TYRduwwcV/2W
 CWFMZg+NNYHXqbGtXy8sytP5+Y/WWsZ6ZOdpXCMc+djyY4/BRiqEnBq5xsRBqaS7ngyiknnG+
 zvfrWZvjfQv/0IumXrjQFytH2p2GP5KUXlLn0blz0/0QjrFjsH32t10+nEX9IDm0k2vzFo3rn
 H+vImuXSBqkBs5JCB1N9WSHfyLQqZpGGC8CXjTT/73qiWTWSs0EWrmkVWMnlp/6nKWn4wq12e
 T4eTtyxL15bq4VfHxXGvrHfvuW+8ClK0PzkOPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 05:10:42PM +0200, Loys Ollivier wrote:
> On Tue 28 May 2019 at 01:32, Paul Walmsley <paul.walmsley@sifive.com> wrote:
> 
> > An update for those testing RISC-V patches: here's a new branch of 
> > riscv-pk/bbl that doesn't try to read or modify the DT data at all, which 
> > should be useful until U-Boot settles down.
[...]
> > Here is an Linux kernel branch with updated DT data that can be booted 
> > with the above bootloader:
> >
> >    https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-experimental
> >
> > A sample boot log follows, using a 'defconfig' build from that branch.  
> 
> Thanks Paul, I can confirm that it works.
> 
> Something is still unclear to myself.
> Using FSBL + riscv-pk/bbl the linux kernel + device tree boots.
> Neither FSBL nor riscv-pk/bbl are modifying the DT.
> 
> Using FSBL + OpenSBI + U-Boot the same kernel + device tree hangs on
> running /init.
> 
> Would you have any pointer on what riscv-pk does that OpenSBI/U-boot doesn't ?
> Or maybe it is the other way around - OpenSBI/U-boot does something that
> extra that should not happen.

Hello,

I don't know which version of OpenSBI you are using, but there is
a problem with the combination of kernel 5.2-rc1 and OpenSBI
versions before commit

  https://github.com/riscv/opensbi/commit/4e2cd478208531c47343290f15b577d40c82649c

that can result in a hang on executing init, so in case you
should be using an older OpenSBI build that might be the source
of the problem that you are experiencing.

Regards,
Karsten
-- 
Ich widerspreche hiermit ausdrücklich der Nutzung sowie der
Weitergabe meiner personenbezogenen Daten für Zwecke der Werbung
sowie der Markt- oder Meinungsforschung.
