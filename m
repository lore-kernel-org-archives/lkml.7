Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982CBC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D65D2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hxXiV6VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgAHMlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:41:07 -0500
Received: from mout.web.de ([212.227.15.4]:37391 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgAHMlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1578487260;
        bh=o+Jd/YOZ9MKB+1RFjh76SrI6cde4B2eR50szFwmMQng=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hxXiV6VWgEBFYhWMI+e8qZgdigPeLokpojEDSXTo0EQ9SmdYKp66Gi4o9au7YUCOQ
         HW8c9Iu7IlOR/bi2TYyRbhfUJx4Y0bPPZQp95/hrr0XBm2I9us8Ka4zROHLxi6wtQH
         U+BKqQWx+BEFQI+a+iwmrZ7sSF0KeX3PlJOzl1cE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.64.251]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFcTl-1isF3849Xp-00Edx1; Wed, 08
 Jan 2020 13:41:00 +0100
Subject: Re: Improving documentation for programming interfaces
To:     Enrico Weigelt <lkml@metux.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <350cd156-9080-24fe-c49e-96e758d3ca45@web.de>
 <20191220151945.GD59959@mit.edu>
 <17931ddd-76ec-d342-912c-faed6084e863@metux.net>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <748b8572-a3b3-c084-e8e3-de420f53e468@web.de>
Date:   Wed, 8 Jan 2020 13:40:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <17931ddd-76ec-d342-912c-faed6084e863@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jvINhDKIyx4pLrlpGU3FXUN97lnG5ta3/ASIhb7oMKREtAAy8FM
 WBtiLrrHDWRLeH4ZfMxFvYyaiouKYwVKkUkV3yA59fdCLntiN2CTKeZLLSljSKJm63vCDYT
 F4mGyjoJQGqbVrXdim5WluZuGJOfKzxkBRURMhCk9/iibkY8yA7yAKRKKRA7rmUrIxn4/XO
 zuC3JqlBtC7j7Jha9ELGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uMIniUp1GTQ=:ONJBpVYLCFrtBTqNk6adZh
 DAutSY2F9lR9mDyxkH81dOhqmXBsXXG9yL1iBDr/Dkhvw5Jt984mpe0LUJdO/wqQvhDNS/BHU
 QE8EGk8hFatud3b1KdFWZc0QhS0/iQwSdryXUUA/pHbieb5UJnG7oMrjX+PIwCgjcgMS90ulG
 D9EXL4GjbkqiEo7ICmIQzZT/gLN05+w3AINl9dAkt74pJqFv11ppvntKIEhlDn1nYe+JjWxAx
 9gVFKEbCsNiA5qcY6I671fCuO6RFda4SW1bBGbt4mOyHuEeIGsnKHx+Otzj1Tvdtma2G9RKnE
 kYvUHWNFGO73FPVU7NxalZ6rHpwhfgq6FJVBC/auk5R5qdyp1+1QJdP9YHXaBEtx3B5fXGsYX
 LPgVoUBMxwi6uxgGkw81kw8r1qEiPafo3qY5iBaleIw/61tyjn+K7mOOgftCuNrAvBRVcMX4Q
 zRUxs5X7gfB/r8KIheAOBfiRb/771u8UujVyybtmcedvunBh5BRp2N5Dkoge6/3mQ0u9n4AW8
 gjMSFe9MeZz7Fhhbhq0U3efnVpslJBPombtq9+yPPXtybZE6UXwiIJZ1IdX8zZGPcVBDFPbzl
 zyuMO2OnA8lccOi7bxHzF8DnHSM2SW8bf/1IPc1t9j0FfFUfyeTZFnDLl10+o4ZTUAKgdP0Tm
 Tc8zQy6rL8LUE/phZkliX4V0jDrCQTs5/ZSFbh7UPZujtHYyZegEuE0yJ/h5oiZdyVb+tuVFJ
 RsYnmQMpabK4AW/oodBxhAuJIaBk1xYwhDwfaG6i9EezEeYK1sFUCAbp3hU3Dhfyv7++SyKOu
 ykJHUZSC2kJ7Yn/FKDn+8dnTd+VveNOeOHN8AYLgeCavKR8MumFB5/FsshxIRm/LBy0e0uJPy
 7nqmgpAnesFKnCFSGTNKBBs1NVIuaJoM2uFBhE76zKghSGDhV6pdEGF2zHaqlVDmOcn5++jBN
 34Kf//ixcWreA8BspEA0EvCSPwSx4dJt6QcJfVDtXncLjYlWySEtSeTGZdw03T3gJrvJfQTdk
 j+8EmeW9YbmIa4Zdk4ypNyNayPWcoQYoZe+ufB7fS3X2PJjbJJeoRFgC5ZQzUM08XI56/dNx1
 WLEcdsMUV7LxTtXWujgt0OmC4W282sBof0mtNt6i7Njk2y3S7YaZNkslrIKlYsvRtksdK05Z7
 qCQytPSList+8SrVJgdM0dGg7cM0fWaw0knoVQi8QisA8STHrC0yVSjiEtX7ZRweailVJbykF
 ImiAQdGE8Pwv5gr1bVc+L7tF8UCV6kKL43wV2NfXCja//uPdBjFsPfUBVDnM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> hmm, maybe we could add some kinda-OOP-style metadata into the type docu=
mentation ?

I hope so.


> Or maybe extend doxygen to crossref types vs functions operating on them=
.

An advanced cross-reference variant would be nice (besides the =E2=80=9CEl=
ixir=E2=80=9D).


>>> It seems that no customised attributes are supported at the moment.
>>> Thus I imagine to specify helpful annotations as macros.
>
> Do you mean _attribute__(...) or comments ?

I propose to encode helpful information into macro calls as needed
for the C programming language.


> I guess he's thinking about some kind of meta-language for expressing
> common things we know from oop-world, like ctors, dtors, getters, etc.

This feedback fits also to my imaginations for a better taxonomy.

Regards,
Markus
