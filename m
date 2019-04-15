Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F082C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2856C20693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfDONPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:15:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38549 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfDONPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:15:24 -0400
Received: from [192.168.1.110] ([95.115.91.41]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmDVA-1gXvCf2ElM-00iDzG; Mon, 15 Apr 2019 15:14:53 +0200
Subject: Re: [PATCH 2/2] tty: add rpmsg driver
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        xiang xiao <xiaoxiang781216@gmail.com>
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <1553183239-13253-1-git-send-email-fabien.dessenne@st.com>
 <1553183239-13253-3-git-send-email-fabien.dessenne@st.com>
 <CAH2Cfb8K5hB=UeMOeTEXud1XZVp12Qbw9NYoxJ0XQK4FFuF3wQ@mail.gmail.com>
 <4857555a-812d-0b96-9a70-2984ffb50ca9@st.com>
 <CAH2Cfb8NzsOZDt8zBypY9ZiD6oOFWUBkZoPpKfU97ZRF_O0z+A@mail.gmail.com>
 <770c71bc-f387-62b6-f799-07ba6446e7e8@st.com>
 <CAH2Cfb87Wacgsh=xz9h9kgwYgBkxNBDbcDJ4W3uPs2LiKbTD9A@mail.gmail.com>
 <760819dc-4c26-b492-a0ba-8b27c189d5b1@st.com>
 <CAH2Cfb-EvWeP28W=Hqzvwaue55hBFCMecqvt3p8mRh52BZMdNg@mail.gmail.com>
 <596f9e4d-2db1-8040-211b-173ad19d9d0e@st.com>
 <CAH2Cfb87+MR5SNmm2zQU+44mV+3gTv4M2moFxQDXhEGHO00W+A@mail.gmail.com>
 <45511e33-df29-1a3c-66a1-151dc42bf10d@st.com>
 <CAH2Cfb9vJG=ujkB9G7P6OmgRZQUiKoH6DGfOu4NuwB+cnXOs1A@mail.gmail.com>
 <6351cde2-7470-40f5-9f3a-c872cb193e50@st.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0c1d34df-7aeb-648b-b118-cf608e6ba636@metux.net>
Date:   Mon, 15 Apr 2019 15:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6351cde2-7470-40f5-9f3a-c872cb193e50@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AYYFxpP0IE3ZsicftjdMNMp5yGC7g8Ed8x5g8IgaojRPa7IR1Wt
 UaFg8wrDbytxhEuR0dwlgbovgK6nxm7bTdFcW9kX3Ln6M8r4Z0pbZhzg5LKT74OtLq2JCEi
 Z3wY0ArZBi/j7W6H4Q5p+RDWidqbAFVmbWpdM6bDRZ0tKM7UhC4ROntoaGSL9PhG6gixYoG
 XtWGERFMGfJ5SSFddYhDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/TSdYI90Kzo=:3eG3ujCn8GBT6MF0Fv8SWZ
 8OWQXcA1v7NQBjxvHb2gOEoZ0kNy1LkCvKHaeZ6co/Pec3WD1sfuWewEiKRaFE9d4s2kBmo2D
 Z+UGipCvp7ueZ4njCsU2/MTYmBaIWM0Yr0bLcaJ5dtf5TDxQYv3Dd7ZR3TBFW5LIhqZHr7uBk
 9Z8dqidir1l0WzMUiJSxB5yZbSyVyQ6LTi1d9LQ4mrHmEQ2r0NLXWdYfO3ZdBZlFcE31NQCiZ
 9IzdLPVdYeEC6/vzOD8I7agXd/BcsX3jGRwbWtez7cDWINCWlbjXbcA5av1BNZjVlezSlbDrL
 e0gRmRSLmJzgJwgGhGiUZZRJCyj11gG1hzPn31oFAfkQzBjtjW1BRlUoklwt8wsbPrYk1MRYZ
 gGTqPuESMXauIhuECmhknb5FxKuB2FlLNweSN253BhW1X/eGtJonXjxXiOSEY5gQ6dKTbkS3z
 WAyowHr6lnJ1eCQTHtjy3DRLia66jFEr9MBPDwpKc9AG4SkY5iskaTAfRDYv7YeNpf8Mcw3OG
 f0AvYjIn/EJKdRqfvz2Hq7OSyAuVPN1YPgUOvx0gqdo+2C9OrYggY/k2j2GhpQ2BqjptQ3fAR
 le1y9862hyAuIv6lHjUrh7CVJuvsIUxyi45RgBTGRHR9yKlxUvshSK4Kvv+T2Gx1qM7rld6io
 aQC1esr/JNYsAYyajMOnbcIuWle36MrRgdcfNOC5Cfuensu+rmYUYnho5H1v8pMMtfzUM1Lrg
 PsSmUgc42h9UQniEgIJoRRQ0VtUUW4kifZrnJmItasCG8XJ3cPJKJJj9S/0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.19 18:00, Arnaud Pouliquen wrote:

Hi folks,

<snip>

Haven't followed the whole thread, but I've got the impression that the
device is emulating an uart - if that's the case wouldn't it be better
to implement a serial driver, instead of tty directly (which IMHO should
make it also usable for serbus-based devices) ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
