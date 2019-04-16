Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEBBC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA28120449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfDPSiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:38:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:46353 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbfDPSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:14 -0400
Received: from [192.168.1.110] ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MrQ2R-1gSozg0JMN-00oWuz; Tue, 16 Apr 2019 20:37:35 +0200
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add
 CLONE_PIDFD]
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian@brauner.io>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, oleg@redhat.com, joel@joelfernandes.org,
        dancol@google.com
References: <20190414201436.19502-1-christian@brauner.io>
 <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <8d1d47cf-3bf1-6c39-c02c-941515be1586@metux.net>
Date:   Tue, 16 Apr 2019 20:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190415195911.z7b7miwsj67ha54y@yavin>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JcoF7ruGi9WnDSkbUJzxBWeTBFSuLepW2wpkuMV9h8I4206Tf/A
 aj/UHWl0DjblOhYGJsqXUeilFPE83wD1NFDNj7ERp6e37Y3ZhQqAK7cMKx6Da3oXve9qabT
 1oQ+CSh6Hg+H2vfSYmRx33KgtX8GS0LGge6Uy+3RvV48tQbtHIsp+azEkUsERMthsR3qNgl
 sJ3ydc3LuuNZOnzgwTBRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:08X1fIcby/k=:/ft9IaL0MpfzKxtwBnk8Yh
 Tm6QMTDRLconR/xjQ1ehvfHkf1xAbpiHDmxq5E42ywAmWLk+jyXW3bWYu0IXxGzosDCCV9dWk
 5IcbfDeqmEVbQz40H01tSjro5tUoCSxsFz5v7CNoASqL/VBxGSiC9/qCCa5z5Xgq5DQr0RbkG
 nyy4L9zYPSE4MiMs465Fc7CIcSyJTr1pmsA5mtJKaGjaM21DATN248S2E5PNq2f1fxRS0UIec
 dGzZ3VGXCmGj66pqEuRZLRsZcWE9OkZtCkFy7B506ebn+ERJUmZv3vB3OGAPGipASPkcaOXCz
 V0IniNDIYrEQMP/iM4tD6n8Rn1Bq4Utv9mUtTwwNq6WgMv1MnREikLq10Hu/90Jj3QwLxJQjw
 h05RfaXJ//qBW/AbRjWhXeMeB9WOkIru0aNq+43vt+L6YJNjk53y4CE/poZSt/SCgU3E6DR4k
 Tz8V8//aLu8ofVg7oJrXXo93Fz6SXGOR2tuAAkbUw2lLj+fY7bvTiNXO8ZM2i5g98Exon4F9W
 KzUEw+ZTeo9aK493OhIFOWxMndgupEjLzAqx/YR9t3m2XI8DS+axhNpa9G67w6YBgP8KPzvyF
 8BEvbyGiXgJ9dV0bOPp2KbgSANhvCZ2Z2dTrPSM5T84s0Za+XfTbJqWO9iPy+9DIz9Xtr9iPN
 cYuruDODnvIv4QhO/hnaWlDX2mGQwV6ldMqk5TUaXZTiRPJcvGiJzdBuKiqYp8kNWTMPbLUEY
 aJdPo92nHhfM8DN6xlkbvrduiJxuGgpKpViLlhvAtOqe2UpemmFYz0lY0gI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.19 21:59, Aleksa Sarai wrote:

> Just spit-balling -- is no_new_privs not sufficient for this usecase?> Not granting privileges such as setuid during execve(2) is the main>
point of that flag.
Oh, I wasn't aware of that. Thanks.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
