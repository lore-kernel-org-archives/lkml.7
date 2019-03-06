Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F119FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF734206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="AdmdaXF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfCFCPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:15:39 -0500
Received: from mx1.cock.li ([185.10.68.5]:48493 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726347AbfCFCPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:15:38 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1551838081; bh=y/QUsG9q124siLuvVZCRwS2E4yG/xbPNyQs4V7qries=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=AdmdaXF7TGeILoFO0aBBJEr5/NTtMn1CkRQHNC2oZrSy5LRNqqGQrWN+6wqFDtXCC
         UsvrcNUoDebrz/YEsFWUadXwSyX+8oz15/dNr2Sh+Wfdd20ZvFiarQnV0AqCdV1zWX
         TjDDBaE+1elSryzaCiTuxrhrE6wfHYCL6osth6OlbPcPMTyI8DILzynT4kMvxqDr+y
         bumpZ0LFqP/6IulguaOlNdR/gTFa4h1Ml8gxVNeHJ5ve2SgJY/V6AnLE449YhCscbE
         hKffK91O8BkiOm9XxGNZdAwMJw+iIFMkBVgFUG7Ti3JClAbq0ItNZRfjiVTRx1sG8s
         7uOcPLjypXycA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Mar 2019 02:08:01 +0000
From:   mikeeusa@redchan.it
To:     linux-kernel@vger.kernel.org, editor@lulz.com, misc@openbsd.org,
        esr@thyrsus.com
Subject: Re: DMCA takedown notice
In-Reply-To: <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5851873@github.com>
References: <5c51daed7c023_2fcf3fe7576d45c417207b@github-lowworker-89d05ac.cp1-iad.github.net.mail>
 <5c51ee838b18f_74e53fd6ff0d45c41780e2@github-lowworker-5909e27.cp1-iad.github.net.mail>
 <5c522f5b6cb8a_60733fc5256d45b412831@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c534f0336ca6_19ae3fcbf5cd45b4186161@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <5c535110f0f30_3aa13fafe46d45c4222962@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <061a28afa26cf5ad7d11f8074353a9cf@redchan.it>
 <5c5489478eb20_56f33fd9e9ad45b43146ec@github-lowworker-4f62d42.cp1-iad.github.net.mail>
 <5c55ecdcb298_3a283fd6dfcd45c4309246@github-lowworker-63e61ec.cp1-iad.github.net.mail>
 <5c563190ae6cc_18c33fcb464d45bc1523b0@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c586b095281b_4c6d3ffba28d45b8120450@github-lowworker-e51511d.cp1-iad.github.net.mail>
 <5c58a56f8ded7_36e93f9cb4ad45b8932e7@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <312c3d91f6c4a71c34b96728a2efb385@redchan.it>
 <5c5b1609a1561_1ac23fbe2d6d45b88762d0@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5812163@github.com>
 <d6326acd7a9a52a5cf4de2bd3841fc5c@redchan.it>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5851873@github.com>
Message-ID: <999ab522ef630b52842e83865a6d6292@redchan.it>
X-Sender: mikeeusa@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My publishing of these notices on my long-held sourceforge account,
along side the download link is sufficient for a reasonable person
to conclude that I, the author of the program, am the issuer of the
request.

This is the very spot that the John Doe has obtained the work.

Secondly it is my exclusive right, as the copyright holder, to control
the distribution of the work as I see fit, and to control the creation
and distribution of derivatives of the work.

I have chosen to do so in rescinding the license of the John Doe.

An exclusive right of mine has been violated by the John Doe 
subsequently,
and with notice of the revocation.

A license, that is not supported by an interest, is revocable in the
United States of America. An interest attaches when a licensee pays
the copyright holder for the receipt of a license, or transmits valuable
bargained-for consideration to the copyright holder. Absent such an 
attached
interest there exists only a revocable-at-will bare license.

Here the John Doe did neither, and does not hold an attached interest
with which to bind me to any supposed promise. Any such promise is 
illusory.

Additionally, the acknowledgement and assent regarding a per-existing
legal duty is not valid consideration.

The url you link to advances a false legal theory unsupported under US 
Jurisprudence.

In the Artifex v Hancom cited by proponents of the "GPL is a contract 
(and always a contract)" view much is made of this proclamation by the 
lower court in the 9th circuit:
  >"Not so. The GNU GPL, which is attached to the complaint, provides 
that the Ghostscript user agrees to its terms if the user does not 
obtain a commercial license."

This is patently false. The GPL contains no such language, The offer to 
do business on the plaintiff's website (regarding the Artifex case) DOES 
contain such language The court conflates that language into "the GPL" 
in this case. The GPL, in fact, declares the the user does not have to 
agree to any of it's terms.

I invite you to consult this learned treatise:
(1) 
https://www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876
In addition to ENFORCING THE GNU GPL by Sapna Kumar (page 16)
(2) http://illinoisjltp.com/journal/wp-content/uploads/2013/10/kumar.pdf
Legal Implications of Open-Source Software by David McGowan, Professor 
of Law, University of Minnesota Law School:
(3) https://papers.ssrn.com/sol3/papers.cfm?abstract_id=249130

All of which explain in concise terms, easily understandable by the lay 
person, why the GPL is revocable from non-paying licensees.

I am an attorney, and I reiterate my demands.
Signed;
--MikeeUSA--



On 2019-02-20 20:10, GitHub Staff wrote:
> Hi MikeeUSA,
> 
> Unfortunately, a pen name does not suffice when used in combination
> with a disposable email address. Whether under the definition in 15
> U.S.C 7006(5) which you cited, or as used in the DMCA, an electronic
> signature needs to be associated with a person, as that term is
> defined by 15 U.S.C. 7006(8). A psuedonym, without other information
> that would allow us to associate that with a specific, identifiable
> person, does not meet 17 U.S.C. 512(3)(a)(i)'s requirement that it be
> signed by an authorized person. As a practical matter, this is
> especially necessary where, as you claim, an account that may not be
> you is posting content using that same pseudonym.
> 
> Even if that were not so, your notice would still be incomplete in two
> other ways.
> 
> First, it lacks "information reasonably sufficient to permit the
> service provider to contact the complaining party," as you've used a
> disposable email address and provided no other contact information
> that would be sufficient to assure we can contact the complaining
> party. This type of reliable contact information is required by 17
> U.S.C. 512(3)(a)(iv).
> 
> Second, your notice does not appear to identify material which
> infringes on any exclusive rights in the original work. Both your
> source code and the repositories you identified are published under
> GPL licenses. You have not identified any way in which those
> repositories violate the GPL, and without more detail we cannot
> determine how redistributing or modifying GPL-licensed code would
> constitute infringing activity. While GitHub is not in a position to
> provide you with legal advice, here is an informative link about the
> irrevocability of GPL licenses:
> https://copyleft.org/guide/comprehensive-gpl-guidech8.html#x11-540007.4
> 
> Once you've revised your notice to include the required details,
> please send back the entire revised notice, and not only the corrected
> sections. Once we've received a complete and actionable notice, we
> will process it expeditiously.
> 
> Thanks,
> 
> GitHub Staff
