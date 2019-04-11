Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608422073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=inuits.eu header.i=@inuits.eu header.b="R9YKnJPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDKPAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:00:47 -0400
Received: from zimbra8.inuits.eu ([136.243.84.118]:46706 "EHLO
        zimbra8.inuits.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:00:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra8.inuits.eu (Postfix) with ESMTP id BE53360957;
        Thu, 11 Apr 2019 17:00:43 +0200 (CEST)
Received: from zimbra8.inuits.eu ([127.0.0.1])
        by localhost (zimbra8.inuits.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LJoRgGTV58PY; Thu, 11 Apr 2019 17:00:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra8.inuits.eu (Postfix) with ESMTP id E45FC609B6;
        Thu, 11 Apr 2019 17:00:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra8.inuits.eu E45FC609B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inuits.eu;
        s=FD9F633A-D6A0-11E7-8AD8-AAD64DD3D410; t=1554994842;
        bh=xiKpIYjmkurJLcceQUPVA1KxSqTI/L3ps5Y3Dy4GdgI=;
        h=Message-ID:From:To:Date:MIME-Version;
        b=R9YKnJPavzNKaLpCtbOxFlVf1qb0Fv60jIyCSrfI2csX36B2+rrSaecIbkGP9B6Kh
         /ngdV2Koi+o4yBdlr7XBtpKopDjGUlOwaQWtHCRCMF5l/Wo408sqfy3aUmgJva2Gsh
         GeX+ZIpnVKFzfYR9D2qhnpoG/eQ1eXR8f/k9TGwGX0j/qKLOPMCzOnDhG/kGHPPWsn
         ZL47A0qwx4xpmntRq7v6kSp2Dy6QO0/a1hu/IgbUAehWj5QiqI+axecnAHQkU8WQE2
         3JSl4xx0gPVo0i51bmeqJ2epT6/tMRNyn1CHVAWlL0J+tSFcdNCjVF8LBO3OLSxBky
         fZn67RACoxItw==
X-Virus-Scanned: amavisd-new at mgmtprod.inuits.eu
Received: from zimbra8.inuits.eu ([127.0.0.1])
        by localhost (zimbra8.inuits.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jGA-HX3uvHfU; Thu, 11 Apr 2019 17:00:42 +0200 (CEST)
Received: from orval.atlantis.local (146-185-54-52.persgroep-ops.net [146.185.54.52])
        by zimbra8.inuits.eu (Postfix) with ESMTPSA id AFA0860957;
        Thu, 11 Apr 2019 17:00:42 +0200 (CEST)
Message-ID: <a07c9008ece0a7584cd1e1762d57673ee3de8fed.camel@inuits.eu>
Subject: Re: [GIT PULL] <global> global spelling corrections for v5.1.0-rc5
From:   Kenny Van de Maele <kenny.vandemaele@inuits.eu>
To:     Randy Dunlap <rdunlap@infradead.org>, torvalds@linux-foundation.org
Cc:     torvalds@osdl.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Apr 2019 17:00:45 +0200
In-Reply-To: <0885bbf9-ccb1-280e-dde1-ffa40282df09@infradead.org>
References: <0b6539fe5b2741b1327119236ea0e401d02003e6.camel@inuits.eu>
         <0885bbf9-ccb1-280e-dde1-ffa40282df09@infradead.org>
Organization: Inuits
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-11 at 07:58 -0700, Randy Dunlap wrote:
> On 4/11/19 2:12 AM, Kenny Van de Maele wrote:
> > are available in the Git repository at:
> > 
> >   git://github.com/vdmkenny/linux-spelling-fix.git tags/common-
> > spelling-fixes-5.1.0-rc5
> > 
> > for you to fetch changes up to
> > 6ee0055f3414a64133228e82004ea60d0e659d6d:
> > 
> >   fix common spelling mistakes (2019-04-11 10:22:24 +0200)
> > 
> > ----------------------------------------------------------------
> > This PR contains a set of global spelling fixes of commonly miss-
> > spelled
> 
> misspelled

Bad joke :)

> 
> 
> Is there a way for me to review the diff on github?

https://github.com/vdmkenny/linux-spelling-fix/commit/6ee0055f3414a64133228e82004ea60d0e659d6d

> 
> thanks.
> 
> 
> > words. Mostly documentation and comments were impacted, but a few
> > lines
> > of code were affected as well.
> > 
> > ----------------------------------------------------------------
> > Kenny Van de Maele (1):
> >       fix common spelling mistakes
> 
> 
-- 
                Kenny Van de Maele
              Open Source Consultant
               https://inuits.eu

                    ..- - .              
                   '        `.           
                  '.- .  .--. .          
                 |: _ | :  _ :|          
                 |`(@)--`.(@) |          
                 : .'     `-, :          
                 :(_____.-'.' `          
                 : `-.__.-'   :          
                 `  _.    _.   .         
                /  /  `_ '  \    .       
               .  :          \\   \      
              .  : _      __  .\   .     
             .  /             : `.  \    
            :  /      '        : `.  .   
           '  `      :          : :  `.  
         .`_ :       :          / '   |  
         :' \ .      :           '__  :  
      .--'   \`-._    .      .' :    `).  
    ..|       \   )          :   '._.'  : 
   ;           \-'.        ..:         / 
   '.           \  - ....-   |        '  
      -.         :   _____   |      .'   
        ` -.    .'--       --`.   .'     
            `--                --        

