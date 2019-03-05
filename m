Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9412C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9278420652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfCEVqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:46:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:40353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfCEVql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:46:41 -0500
Received: from [192.168.20.60] ([92.116.130.110]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRo6b-1gYr0x3lqj-00StVO; Tue, 05
 Mar 2019 22:45:59 +0100
Subject: Re: [PATCH v3 15/34] parisc: mm: Add p?d_large() definitions
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-16-steven.price@arm.com>
 <fa3072ba-f02b-fee5-dc16-d575a5308d4b@gmx.de>
 <20190301221213.snm7cwowr67pdifs@kshutemo-mobl1>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <6d2bc08b-d336-1b1a-2408-6259dafff995@gmx.de>
Date:   Tue, 5 Mar 2019 22:45:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301221213.snm7cwowr67pdifs@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LdLxPVii8ZtTFSzQTHGX/xHJKUnsknfi5/X+gB/PzHjktFyjw4X
 qKKtlrR+3kluRrRkObR/s+jd+5A00AT3VdqIHUj3NAuH7L23fRp4hj2q4b6uXoYSv7gCg37
 9+bmlps0QIP0hHILRXnGjB53IQG26fmh22jSuDvpR9+XdUgQltKRTxWKrHQdMyo6dLC9uCl
 e/V2AkiGVtdD2CAE7+CUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HktD2wX0SxY=:TZE6v4h4jobkREHdJwbGx8
 BWzDw3iX8u+XXdCOfOLaxSsJA7VV1dHMh5unrQsl3AZkt8PZZF89XlTSIuKRFkSbqPw35EEEl
 +GvV1tII9xNLY21OZwsNgasmUsStflRtpSbQdjuH6IBwr6hlZqL+A5USD3rMRPq0OYnykPKGi
 Hz0/mHZhIuSn1lq7pGTBxiIsN8YQjFSvJDkUfT1xeoOOKD+t+XbfWdCvWQq6r/RfrEi2IJJqM
 ry8TJJFrnkCLEGns9Zx/BIV9hjRhCR91PnmkMdfrQuqu926+pujR/9mcKgDMqf1NaZhapif8g
 qhc6SG8nhdrxZyPxE1XRXY8wSsOLFz/gDr3GW4BzFlUQCl+KgGjW469L/ZYOGngSkKxyDeUmc
 Ro3PUtyxOOr3R2Cmekis/SI/ZBkq8p85QbFNXfm3DWMf6yNMTo1PkLsdrnbekkuZGr1y/tRI5
 WuQsnfx1KTUBcUdc8ShEw8bjfVaj2d/HRRs5Q6lLcY7LsCzDUQYAyeLNHXJjeT3nZiq/JVb+Y
 3Deu5RSBG3mzFFLyKYCWLyWfKjSUPZDv61D5iMAAQ5jr730M9J74GmYXM//P54jPGxoSg+esy
 fUeOIDtx9Sn2tF3daNFwUayrfe0R6Xqht+8AZeAqqlaYhWdJDUrePu93SD8sCB4nKIfeop+s0
 f7pbCrae5StemWN0KnN187j/V6JlednDsEnp2PEuokQICT+v3eyjMCL0iKcNFgyikpif2O+kI
 eTj564By3p6f3I5ViS6HmHiedEgfY9Yq/FEDQD+k7QfdNs3e3TIlRDKXDhatgisKMpBJAWdy6
 gJ/xjtp/rsZ7k7IaaVNxoJC4r3DH5LopwcYJKYY1e41rj1upzE2CwSq0fJPLvceXcNDHjkDy1
 DYMotrIdKhNiRBvFsdywLcb4SpgFDEtoi8gZOyEPHlcwRYkxPtr9kCIDz0I8l+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.19 23:12, Kirill A. Shutemov wrote:
> On Wed, Feb 27, 2019 at 07:54:22PM +0100, Helge Deller wrote:
>> On 27.02.19 18:05, Steven Price wrote:
>>> walk_page_range() is going to be allowed to walk page tables other than
>>> those of user space. For this it needs to know when it has reached a
>>> 'leaf' entry in the page tables. This information is provided by the
>>> p?d_large() functions/macros.
>>>
>>> For parisc, we don't support large pages, so add stubs returning 0.
>>
>> We do support huge pages on parisc, but not yet on those levels.
> 
> Just curious, what level do parisc supports huge pages on?
> AFAICS, it can have 2- or 3- level paging and the patch defines helpers
> for two level: pgd and pmd. Hm?

You are correct.
My comment was misleading and meant to say that we do support generic
huge pages for applications.

Helge
