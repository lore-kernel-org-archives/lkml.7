Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E050C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6529C21872
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="pGD8i4Rk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCPDVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:21:07 -0400
Received: from cock.li ([185.100.85.212]:56806 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfCPDVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:21:07 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1552706462; bh=f+TlxXuAHFFsoM77ptBvnfVH4AWgtmK2gi+HMVnPC5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pGD8i4RkuTgvxu9HebUXI67xb+qXNyp84bYwMJhofXn4PGvORBA1J4vmhvGni8pGF
         HEGp2k6Qeoyh6U3Lc8rrl2KLRJ2KwkRoNwpGzhDh28RED4qwgbDYuokfuakrSOUdxX
         4zqstC6MwOIFLzjnTNNRX9CzGb1G9B9K87A1BY8s8ezgTtYiLsXe2k+I1lDpVEwChD
         2+uUCp37iLaeq7kHW02wqrZvRfHdvaLBfMQgfepEDyWEaeiK02F3IchUQuGXRmcVOq
         1SauEjSAhb8RHPa5x+QW/YUno1Hd6Ow4qfpHC6BWdwCwP/eb8/bRBaJ+FZ7KahdPqz
         McqiNfLnJM4lw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 Mar 2019 03:21:02 +0000
From:   mikeeusa@redchan.it
To:     GitHub Staff <support@github.com>
Cc:     linux-kernel@vger.kernel.org, esr@thyrsus.com, misc@openbsd.org
Subject: Re: DMCA takedown notice
In-Reply-To: <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5870232@github.com>
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
 <1ad00463db02ac58f89c4ac99b2299e4@redchan.it>
 <CAKSHBJW4qkrozz0HrWvXnbpHicSBRoRKycC7xBoK0uWZJx5NkQ@mail.gmail.com>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5870232@github.com>
Message-ID: <72d085e3d1e9c2abf1967ceb40c3f988@redchan.it>
X-Sender: mikeeusa@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am going to sue your staff for contributory copyright infringement in 
their personal capacity, in addition to you company.
I have given you ample notice to remove the work.

> Moreover, you have not addressed other doctrines, such as reliance or 
> promissory estoppel, which would prevent revocation even in the absence 
> of valuable consideration.

These are equitable defenses. Not defenses-at-law. They are determined 
on a case by case basis. Promissory estoppel is most often "awarded" 
when a defendant has, on the reliance of explicit promises to him by the 
owner, laid out monies to purchase improvements for the affected 
property.

An example is when one builds extra buildings on a piece of land one was 
promised ownership on upon the owners death.  It is much related to the 
old Livery of Seisin which was used in the conveyance of land and is, in 
fact, a modern substitute for it.

There is little relevance between such and a licensee, one of many, who, 
for no outlay, had permission to use a piece of software. Permission 
which was later revoked.

> Similarly, based on the information you've provided, we are unable to
> locate facts which would support for your argument that any of the GPL
> licensed code here was granted that license without an exchange of
> valuable consideration.

The John Doe would have to prove that there was a contract, it is not 
me, the copyright holder, who's duty it is to show that there was none.
One cannot prove a negative. You know this very well.
It is the consideration (payment) that would create a contract which a 
licensee could attempt to rely upon.
Where there is no such consideration there is no contract.

Here the John Doe admitted that he simply downloaded the work and also 
admitted that there was no contract between him and I
"Thank God", he added.

This is attested to in the original complaint, the John Doe is quoted, 
and his testimony is linked.
However it is not my duty to prove to you that there is _not_ any 
consideration.

That is proving a negative. It is a duty of the John Doe's defense to 
prove that there is such a payment, which there is not.
I was never paid by the John Doe.

You are being completely disingenuous here. You think you are clever, 
but you will be sorry once my legal bill is being paid out of your 
personal expenses for your blatant copyright infringement of my work. 
The courts won't think you're "cute" or "clever".

I have addressed your claim that my signature was invalid. Your 
understanding of what is required of a signature and the purpose of a 
signature is incorrect. A signature simply shows assent of the party to 
the validity of the document. An X is sufficient. Here I have chosen to 
use my long-held pen name, MikeeUSA. I have also published these notices 
at the place of the publication of the work, to give further 
confirmation.

https://sourceforge.net/projects/gpcslots2/
https://sourceforge.net/projects/gpcslots2/files/notes/

Forewarned is forearmed.

Sincerely,
Signed,
--MikeeUSA--


On 2019-03-07 02:30, GitHub Staff wrote:
> Hi MikeeUSA,
> 
> I've done my best to address your concerns below. Until you provide a
> complete DMCA takedown notice, we are unable to act on your request.
> 
>> My publishing of these notices on my long-held sourceforge account,
>> along side the download link is sufficient for a reasonable person
>> to conclude that I, the author of the program, am the issuer of the
>> request.
> 
> As explained in our previous email, that is not the standard required
> by 17 U.S.C. 512(3)(a)(i).
> 
>> I have chosen to do so in rescinding the license of the John Doe.
> 
> Based on the information you've provided, we are unable to determine
> that any valid license revocation has taken place here.
> 
>> A license, that is not supported by an interest, is revocable ...
>> An interest attaches when a licensee pays
>> the copyright holder for the receipt of a license, or transmits 
>> valuable
>> bargained-for consideration to the copyright holder. Absent such 
>> anattached
>> interest there exists only a revocable-at-will bare license.
> 
> Similarly, based on the information you've provided, we are unable to
> locate facts which would support for your argument that any of the GPL
> licensed code here was granted that license without an exchange of
> valuable consideration. Moreover, you have not addressed other
> doctrines, such as reliance or promissory estoppel, which would
> prevent revocation even in the absence of valuable consideration.
> 
>> The url you link to advances a false legal theory unsupported under US
>> Jurisprudence.
> 
> While they are in easily-missed footnotes, the linked article contains
> citations to three cases which support their respective underlying
> legal theories. Please note the article is provided for informational
> purposes, and GitHub is unable to give legal advice about open-source
> licensing or copyright questions.
> 
> If you would like to revise your notice to include the required
> details, please send back the entire revised notice, and not only the
> corrected
> sections. Once we've received a complete and actionable DMCA notice,
> we will process it expeditiously.
> 
> Thanks,
> 
> GitHub Staff
