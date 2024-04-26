% Generate m-sequence
function seq = tx_gen_m_seq(m_init)
% MSRG architecture
connections = m_init;
m = length(connections); % ��λ�Ĵ����ļ���
L = 2 ^ m - 1; % m���г���
registers = [zeros(1, m-1) 1]; % �Ĵ�����ʼ��
seq(1) = registers(m); % m���еĵ�һλȡ��λ�Ĵ�����λ�����ֵ
for i = 2:L
    % �¼Ĵ����ĵ�һλ��������ֵ�˼Ĵ������һλ
    new_reg_cont(1) = connections(1) * seq(i - 1);
    for j=2:m
        % ����λ����ǰ�ߵļĴ���ֵ��������ֵ�˼Ĵ������һλ
        new_reg_cont(j) = rem(registers(j - 1) + connections(j) * seq(i - 1), 2);
    end
    registers = new_reg_cont;
    seq(i) = registers(m); % ����һ��ѭ���Ĵ������һλ�õ�m���е�����λ
end
end

