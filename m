Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBA4C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 11:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C01B206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 11:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfD0L7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 07:59:13 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55467 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0L7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 07:59:13 -0400
Received: from [192.168.1.110] ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIxBa-1h5RRY1Qza-00KPNy; Sat, 27 Apr 2019 13:58:02 +0200
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without
 UPF_BOOT_AUTOCONF
To:     Esben Haabendal <esben@haabendal.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-2-esben@geanix.com>
 <20190426143946.GX9224@smile.fi.intel.com> <871s1og11u.fsf@haabendal.dk>
 <20190426215103.GD9224@smile.fi.intel.com> <87tvejakot.fsf@haabendal.dk>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <7a1fd6cc-050f-a077-6169-03552a89c563@metux.net>
Date:   Sat, 27 Apr 2019 13:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87tvejakot.fsf@haabendal.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4flezNchAqKfpAtbNjrolxPrXbXD5cySQuhZgrTuHUCA2klmovP
 Ibh0oW8Hla2JeGsm6hyzlFtr4LypkbYBSWBUmiiK7JUEYN2nT2eCtcVP7UFtpzfcvzuc3fH
 GJY/Syt7NJqtAoc+o2xizs+gwsSJz8o+3XpgG2+pGmn9nMZ6XTF7DNW7vmAt0v34EUbrMul
 ML08i20pKtp2Eoa5ZzuVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xEUlakykATA=:JM67TyKTPMpGv4E3X7GvN4
 0BHvdiZLJpA9LraDBCEhcNm+hHctR4cbL+DQCE9bkgrmW8Tuc9LAZ20dbAOuc3BXX/B8nEqrz
 hEfTy5B7s5z5PDRi2QBAk/zzLjE28lFH2u+wukvsdHCi5+0tzExxiCI7a6I7Z75NWRQpoRtsV
 0cIsID4KI/BfMsVwQDi25AxwnrNNe9mqlUEDOPjefGn0OsFRYEIzaioQ5F9/+4W/9faRhvcaH
 hyz6SwZ7W87Ciua1gCwi+Yx5Pnlk/P+3GLx0MXBRcwLQJzkCBf06l/Qkx7l/L0o6pcAXEzWlI
 c9gUya2Y2CzzU8lwy2ofHzN7+UuYrt5thj3fN3Li/SYMiob7ahgckcZxM4e9I2e5Z/SpjQaTf
 rNF0bMtfAt0/eHmfdaWdZaKU171AjIWqPur/UGW92WprtFzTSFvcUW42tCGRuBBGiszCi3UoJ
 DFnhURN5NLzyPBEdI146NRHwzjJCFWfzLeR8iggQLDdP4bYIoqQgb4k+YsGNNAFELs/cBFS4l
 54YaX77WyuIIzfQusi+WHhX2NW+05lCFthdxzoOZEeWxDamvWgOE8QO8hkEO/eAFwE31TfRD4
 x286l1Kk4a0/mLQgbnDNBpp4xJUx+6/Lzs+wFuteCCE68EfANQ4cAEUS3V+XEAWFAPaalFaYO
 JEmbDiBXZNtZBbgVX3+g7pEhd4ISZ9ONsVSD7h9uNGhRCQcgpCk8NdRzkjg6K4lqT+oZBFk9P
 U/OQ4FUp6hZPWeTtI8J8wXY1hRoTQcuwW4AN9gweOM674vTn1eBM1WNxlh8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.19 10:58, Esben Haabendal wrote:

Hi folks,

> That said, the purpose of UPF_BOOT_AUTOCONF (for 8250 driver) is to> request and map the register memory.  So when that is already done by>
the parent MFD driver, I think it is silly to workaround problems
caused> by UPF_BOOT_AUTOCONF being force setted, when it really shouldn't.
I tend to agree. Maybe we should give serial8250_register_8250_port()
some flags for controlling this, or add another function for those
cases.

A minimal-invasive approach could be introducing an
serial8250_register_8250_port_ext() with extra parameters, and let
serial8250_register_8250_port() just call it.


By the way: the mem-mapping code pathes in serial8250 are a bit strange
anyways, eg. serial8250_port_size() is always called when map/unmap is
done, and this function does special logic for certain devices.
IMHO, it this should be called only once on device init and later just
use the already computed value:

https://github.com/metux/linux/commit/7ec63b699c910228b92cfb27eb8edfda90fdfd63

(haven't sent this queue yet, but feel free to cherry-pick if you like)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
